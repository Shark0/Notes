# EC2

## Instance
虛擬機，有不同價錢方案，每個類型有不同的CPU、Memory、網路效能。

## Amazon Machine Image (AMI)
灌入Instance的OS與軟體。

## AMI Marketplace
選擇AMI的賣場，有些Image免費有些要收費。

## User Data
Instance啟動時的執行腳本。

## EBS
Instance Volume的地方，讓Instance不論何時可以mount到同一個Volume，確保資料不會遺失。

## Elastic Network Interface
可以想像成是Instance的網路卡，讓每個Instance有個IP。

## Security Group
控制Instance Inbound / Outbound的通訊協定、Port、Source/Destination

### Inbound

| Type | Protocol | Port Range | Source    | Description |
|------|----------|------------|-----------|-------------|
| HTTP | TCP      | 80         | 0.0.0.0/0 |             |
| SSH  | TCP      | 22         | 0.0.0.0/0 |             |

### Outbound

| Type        | Protocol | Port Range | Destination | Description |
|-------------|----------|------------|-------------|-------------|
| All traffic | All      | All        | 0.0.0.0/0   |             |

## Key Pair
連線進Instance的SSH金鑰

## Tag
方便辨識Instance

## Snapshot
將Instance內容備份成Image，備份完可以存到EBS或是AMI。


