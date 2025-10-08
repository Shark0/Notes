# 分散式多工處理中使用 RDB 搭配樂觀鎖的原理

分散式多工處理（Distributed Multiprocessing）可以使用關係型資料庫（RDB，如 MySQL、PostgreSQL）作為任務儲存和協調中心，搭配**樂觀鎖（Optimistic Locking）**來實現任務的原子分配。這比純 Queue 更適合需要資料一致性和事務的場景（如金融系統），因為 RDB 提供 ACID 保證。樂觀鎖假設衝突少（多讀少寫），不鎖定資源，而是用版本檢查來避免並發問題。以下一步步講解其原理，包含概念、流程和範例。

在實際分散式環境中，多 Worker 可跑在不同機器，共享同一 RDB。這個範例展示了核心邏輯：版本檢查確保安全。

## 1. **基本概念**
- **RDB 的角色**：任務儲存在 RDB 的表格中（如 `tasks` 表），包含欄位：`id`（任務 ID）、`status`（狀態：pending/processing/done）、`data`（任務資料）、`workerId`（版本號，用於樂觀鎖）。
- **樂觀鎖的機制**：不使用悲觀鎖（Pessimistic Locking，如 SELECT FOR UPDATE 鎖定行），而是用版本欄位（timestamp 或整數）追蹤變更。更新時檢查版本是否匹配，若不匹配則衝突，重試。
    - 優點：不阻塞其他讀取，適合高並發讀取。
    - 缺點：衝突時需重試，可能浪費資源。
- **生產者-消費者模式**：生產者插入 pending 任務；多個 Worker（消費者）競爭取出並標記為 processing。

## 2. **運作原理**
原理基於**原子更新**和**版本驗證**，確保多 Worker 同時嘗試時，只有一個成功取出任務。流程如下：

- **步驟 1: 任務產生與插入**
    - 生產者插入新任務到 RDB：`INSERT INTO tasks (status, data, version) VALUES ('pending', '任務資料', 0)`。
    - RDB 自動產生 ID，任務進入 pending 狀態。

- **步驟 2: Worker 取出任務（樂觀鎖檢查）**
    - Worker 產出一個用來搶奪任務WorkerId
    - 然後嘗試更新：`UPDATE tasks SET status = 'processing', wroker_id = ${worker_id} WHERE (status in ('pending', 'failed') and worker_id is null) or (status = 'processing' and task_start_time - current_timestamp > 5 minutes)`
        - 如果更新影響行數 == 1：成功！Worker 取得任務，開始執行。
        - 如果影響行數 == 0：表示其他 Worker 已更新（版本不匹配），任務被搶走，重試步驟 2。
    - 若更新影響是1，拿worker id找到任務開始工作

- **步驟 3: 任務執行與結果處理**
    - Worker 執行任務（e.g., 計算或 I/O）。
    - 完成後，再次用樂觀鎖更新：`UPDATE tasks SET status = 'done', result = '結果' WHERE worker_id = {workder_id}`。
    - 若失敗，可重試或更新為 'failed'。

- **步驟 4: 監控與擴展**
    - 主控監控 `SELECT COUNT(*) FROM tasks WHERE status = 'pending'`，若任務堆積，動態啟動更多 Worker。
    - 支援分頁或索引優化查詢，避免全表掃描。

簡單流程圖（文字版）：
   ```
   生產者 → INSERT pending 任務 → RDB 任務表
                                       ↓
   Worker 1 ← SELECT pending + UPDATE (version check) ← RDB → Worker 2
                                       ↓ (若衝突，重試)
   執行任務 → UPDATE done (version check)
   ```

## 3. **優點與挑戰**
這種方式結合 RDB 的強大查詢和樂觀鎖的輕量鎖定，適合資料驅動的分散式系統。

| 優點          | 說明                         |
|-------------|----------------------------|
| **一致性**     | RDB 事務保證 ACID，樂觀鎖確保原子分配。   |
| **靈活性**     | 易查詢任務狀態（SQL），支援複雜條件（如優先級）。 |
| **容錯**      | 任務持久化，若 Worker 崩潰，可重新分配。   |
| **無需額外中間件** | 純 RDB，部署簡單。                |
