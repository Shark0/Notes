# Transformer介紹
self-attention的架構
## Transformer 家族總覽
| 模型名稱                              | 核心用途        | 架構變化                | 發布年份      | 特點 / 關鍵技術                            |
|-----------------------------------|-------------|---------------------|-----------|--------------------------------------|
| Transformer (原始)                  | 通用編碼 / 解碼器  | Encoder-Decoder     | 2017      | Attention is All You Need，NLP 大革命的開端 |
| BERT                              | 文本分類、問答     | Encoder-only        | 2018      | 雙向訓練，Masked LM，NLP 基石                |
| RoBERTa                           | BERT 升級版    | Encoder-only        | 2019      | 無Next Sentence、更多資料與訓練時間             |
| ALBERT                            | 記憶體節省版 BERT | Encoder-only        | 2019      | 參數共享、因子分解 Embedding                  |
| DistilBERT                        | 輕量版 BERT    | Encoder-only        | 2019      | Knowledge Distillation，小而快           |
| XLNet                             | 序列建模        | Encoder-only        | 2019      | 結合自回歸與雙向訓練，取代 BERT？                  |
| ELECTRA                           | 文本分類、問答     | Encoder-only        | 2020      | Generator + Discriminator，效率超高       |
| T5                                | 文本到文本任務     | Encoder-Decoder     | 2020      | Text-to-Text Transfer，問答、翻譯、摘要都可做    |
| mT5                               | 多語言 T5      | Encoder-Decoder     | 2020      | 支援 100+ 語言                           |
| BART                              | 生成任務、摘要     | Encoder-Decoder     | 2020      | 把 BERT + GPT 合併起來的結構                 |
| mBART                             | 多語言 BART    | Encoder-Decoder     | 2020      | 多語言翻譯與摘要任務利器                         |
| GPT-2/3/4                         | 生成任務        | Decoder-only        | 2019–2023 | 自回歸生成，超大語言模型                         |
| OPT / BLOOM                       | GPT 類型替代品   | Decoder-only        | 2022      | Meta / BigScience 推出，開源替代品           |
| ChatGPT / GPT-4 / Claude / Gemini | 對話、推理       | Decoder-only + RLHF | 2022+     | 微調 + 對齊人類偏好（RLHF），多模態能力              |

## 架構分類重點
| 架構              | 代表模型	                  | 適合任務              |
|-----------------|------------------------|-------------------| 
| Encoder-only    | BERT, RoBERTa, ELECTRA | 分類、問答（抽取式）、語句相似度  |
| Decoder-only    | GPT, OPT, ChatGPT      | 自然語言生成、對話、推理      |
| Encoder-Decoder | T5, BART, mBART        | 翻譯、摘要、問答（生成式）、多任務 |

## 應用對應建議
| 任務        | 建議模型                         |
|-----------|------------------------------|
| 語意相似度     | BERT, RoBERTa, Sentence-BERT |
| 文本分類      | BERT, RoBERTa, ALBERT        |
| 問答任務（抽取式） | BERT, ELECTRA                |
| 問答任務（生成式） | T5, mT5, BART                |
| 翻譯任務      | mBART, T5, MarianMT          |
| 摘要任務      | BART, T5                     |
| 文本生成 / 對話 | GPT-2/3/4, ChatGPT, Claude   |
| 多語言處理     | mBERT, XLM-R, mT5, mBART     |