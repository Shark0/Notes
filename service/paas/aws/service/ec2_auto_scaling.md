# EC2 Auto Scaling
若特定時段請求會高於現有Instance能觸裡的數量時，可以根據Scaling Policy設定Auto Scaling來有條件的擴展Instance數量。

## Scaling Policy
* 維持固定數量
* 時間排程擴增
* 按用量進行擴增
  * Simple Scaling
  * Step Scaling
  * Target tracking Scaling
