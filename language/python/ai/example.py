import torch
import torch.nn as nn
import torch.optim as optim
import numpy as np
from torch.utils.data import Dataset, DataLoader
import uuid

# 假設資料參數
num_users = 1000  # 消費者數量
num_articles = 2000  # 文章數量
vector_dim = 64  # Category Vector和Topic Vector的維度
num_likes = 5000  # 點讚紀錄數量

# 模擬資料生成
np.random.seed(42)
user_vectors = np.random.rand(num_users, vector_dim).astype(np.float32)  # 消費者Category Vector
article_vectors = np.random.rand(num_articles, vector_dim).astype(np.float32)  # 文章Topic Vector
like_records = [(np.random.randint(0, num_users), np.random.randint(0, num_articles)) for _ in range(num_likes)]  # 點讚紀錄

# 自定義Dataset
class LikeDataset(Dataset):
    def __init__(self, like_records, user_vectors, article_vectors):
        self.like_records = like_records
        self.user_vectors = user_vectors
        self.article_vectors = article_vectors
        self.num_articles = article_vectors.shape[0]

    def __len__(self):
        return len(self.like_records)

    def __getitem__(self, idx):
        user_id, pos_article_id = self.like_records[idx]
        neg_article_id = np.random.randint(0, self.num_articles)  # 隨機負樣本
        while (user_id, neg_article_id) in set(self.like_records):  # 確保負樣本未被點讚
            neg_article_id = np.random.randint(0, self.num_articles)

        user_vec = self.user_vectors[user_id]
        pos_article_vec = self.article_vectors[pos_article_id]
        neg_article_vec = self.article_vectors[neg_article_id]

        return (
            torch.tensor(user_vec, dtype=torch.float32),
            torch.tensor(pos_article_vec, dtype=torch.float32),
            torch.tensor(neg_article_vec, dtype=torch.float32)
        )

# Transformer-based 推薦模型
class TransformerRecommender(nn.Module):
    def __init__(self, vector_dim, nhead=4, num_layers=2, hidden_dim=128):
        super(TransformerRecommender, self).__init__()
        self.vector_dim = vector_dim

        # Transformer Encoder for user vectors
        encoder_layer = nn.TransformerEncoderLayer(d_model=vector_dim, nhead=nhead, dim_feedforward=hidden_dim)
        self.user_encoder = nn.TransformerEncoder(encoder_layer, num_layers=num_layers)

        # Transformer Decoder for article vectors
        decoder_layer = nn.TransformerDecoderLayer(d_model=vector_dim, nhead=nhead, dim_feedforward=hidden_dim)
        self.article_decoder = nn.TransformerDecoder(decoder_layer, num_layers=num_layers)

        # 最終線性層輸出匹配分數
        self.fc = nn.Linear(vector_dim, 1)
        self.sigmoid = nn.Sigmoid()

    def forward(self, user_vec, article_vec):
        # user_vec: (batch_size, vector_dim)
        # article_vec: (batch_size, vector_dim)

        # 增加序列維度以符合Transformer輸入 (seq_len=1, batch_size, vector_dim)
        user_vec = user_vec.unsqueeze(0)
        article_vec = article_vec.unsqueeze(0)

        # Transformer處理
        user_encoded = self.user_encoder(user_vec)
        article_decoded = self.article_decoder(article_vec, user_encoded)

        # 移除序列維度並計算分數
        output = self.fc(article_decoded.squeeze(0)).squeeze(-1)  # (batch_size,)
        return self.sigmoid(output)

# BPR損失函數
def bpr_loss(pos_score, neg_score):
    return -torch.mean(torch.log(torch.sigmoid(pos_score - neg_score)))

# 訓練模型
def train_model(model, dataloader, epochs=10, lr=0.001):
    optimizer = optim.Adam(model.parameters(), lr=lr)
    model.train()

    for epoch in range(epochs):
        total_loss = 0
        for user_vec, pos_article_vec, neg_article_vec in dataloader:
            user_vec = user_vec.cuda()
            pos_article_vec = pos_article_vec.cuda()
            neg_article_vec = neg_article_vec.cuda()

            # 正向和負向分數
            pos_score = model(user_vec, pos_article_vec)
            neg_score = model(user_vec, neg_article_vec)

            # 計算BPR損失
            loss = bpr_loss(pos_score, neg_score)

            # 反向傳播
            optimizer.zero_grad()
            loss.backward()
            optimizer.step()

            total_loss += loss.item()

        print(f"Epoch {epoch+1}/{epochs}, Loss: {total_loss/len(dataloader):.4f}")

# 推薦函數
def recommend_articles(model, user_id, user_vectors, article_vectors, top_k=5):
    model.eval()
    user_vec = torch.tensor(user_vectors[user_id], dtype=torch.float32).cuda()
    article_vecs = torch.tensor(article_vectors, dtype=torch.float32).cuda()

    with torch.no_grad():
        scores = []
        for i in range(article_vecs.shape[0]):
            score = model(user_vec.unsqueeze(0), article_vecs[i].unsqueeze(0)).item()
            scores.append((i, score))

    # 按分數排序並返回前K個文章
    scores.sort(key=lambda x: x[1], reverse=True)
    return [article_id for article_id, _ in scores[:top_k]]

def recommend_users(model, article_id, user_vectors, article_vectors, top_k=5):
    model.eval()
    article_vec = torch.tensor(article_vectors[article_id], dtype=torch.float32).cuda()
    user_vecs = torch.tensor(user_vectors, dtype=torch.float32).cuda()

    with torch.no_grad():
        scores = []
        for i in range(user_vecs.shape[0]):
            score = model(user_vecs[i].unsqueeze(0), article_vec.unsqueeze(0)).item()
            scores.append((i, score))

    # 按分數排序並返回前K個消費者
    scores.sort(key=lambda x: x[1], reverse=True)
    return [user_id for user_id, _ in scores[:top_k]]

# 主程式
if __name__ == "__main__":
    # 設置設備
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

    # 準備資料
    dataset = LikeDataset(like_records, user_vectors, article_vectors)
    dataloader = DataLoader(dataset, batch_size=32, shuffle=True)

    # 初始化模型
    model = TransformerRecommender(vector_dim=vector_dim).to(device)

    # 訓練模型
    train_model(model, dataloader, epochs=10)

    # 推薦範例
    user_id = 0
    recommended_articles = recommend_articles(model, user_id, user_vectors, article_vectors, top_k=5)
    print(f"Recommended articles for user {user_id}: {recommended_articles}")

    article_id = 0
    recommended_users = recommend_users(model, article_id, user_vectors, article_vectors, top_k=5)
    print(f"Recommended users for article {article_id}: {recommended_users}")