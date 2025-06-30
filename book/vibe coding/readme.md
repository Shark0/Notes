# Vibe Coding

工具: https://claude.ai/

## 實作
拿尚未實作的Affiliate Store的Rebate Setting來實驗

### 第一步
在PM匯集User需求後，寫下相關User Story，並把User Story的相關頁面特徵與操作寫成條列式的Prompt，如下方的1 - 4 點，透過Vibe Coding來產出一個範例跟UI + RD講解需求。
```
我想建置一個Rebate Setting管理頁面

1. 頁面一進去可以看到Rebate Setting列表

2. Rebate Setting的資料有'產品類別'、'子產品類型'、'系統名稱'、'子系統名稱'、'傭金參數'、'訂單產品'、'產品類型'、'傭金比例'、'回扣比例'

3. 使用者可以點擊"新增"按鈕，跳出一個視窗來新增Rebate Setting，並在輸入完資料"確定"時新增Rebate Setting

4. 使用者點擊Rebate Setting列表某個Item右側的修改選項，跳出一個視窗來修改Rebate Setting，並在輸入完資料"確定"時修改Rebate Setting
```

Vibe Coding建立出來的範例: https://claude.ai/public/artifacts/45da92fd-38a8-4443-9e20-2d70a430ada1

[代碼](step1_code.md)

### 第二步

PM提供的Prompt產出的代碼基本無法放在專案，原因就是Prompt產出的範例資料都是假資料，前端工程師就算複製貼上也要在邏輯代碼方面做出大量修改，因此這邊建議RD在PM的Prompt上進一步加入兩點

* Data Model的定義(下方第五點)，可由前後端工程師討論或產生
* Function Interface的定義(下方第六點)，讓AI根據定義好的Function來實做邏輯，之後要把假資料的代碼轉成跟API串接也能方便知道修改目標在哪

```
我想建置一個Rebate Setting管理頁面

1. 頁面一進去可以看到Rebate Setting列表

2. Rebate Setting的資料有'產品類別'、'子產品類型'、'系統名稱'、'子系統名稱'、'傭金參數'、'訂單產品'、'訂單產品類型'、'傭金比例'、'回扣比例'

3. 使用者可以點擊"新增"按鈕，跳出一個視窗來新增Rebate Setting，並在輸入完資料"確定"時新增Rebate Setting

4. 使用者點擊Rebate Setting列表某個Item右側的修改選項，跳出一個視窗來修改Rebate Setting，並在輸入完資料"確定"時修改Rebate Setting

5. Rebate Setting 的 Data Mode為
   interface RebateSettingData {
   id: number;
   productType: string;
   subProductType: string;
   systemName: string;
   subSystemName: string;
   commissionParameter: string;
   orderProduct: string;
   orderProductType: string;
   commissionRate: number;
   rebateRate: number;
   }

6. Rebate Setting 的 Controller Function為

RebateSettingControllerInterface {
function readRabteSettingList()//讀取Reabate Setting
function createRebateSetting(rebateSetting: RebateSetting)//建置 Reabate Setting
function updateRebateSetting(rebateSetting: RebateSetting)//更新 Reabate Setting
}
```

Vibe Coding建立出來的範例: https://claude.ai/public/artifacts/2acac1b6-4ae6-491a-9ebb-467f285c5a57

[代碼](step2_code.md)


### 第三步

接下來就是要怎麼方便將範例UI替換成公司UIUX團隊設計? 若有能事先定義好Model並用MVVM開發，把View的代碼竟可能的做到獨立，就能在替換UI後花最少的工將View綁定Model，解耦前端跟UI。

因此我們在額外要求要用MVVM來開發(下方第七點)


```
1. 頁面一進去可以看到Rebate Setting列表

2. Rebate Setting的資料有'產品類別'、'子產品類型'、'系統名稱'、'子系統名稱'、'傭金參數'、'訂單產品'、'訂單產品類型'、'傭金比例'、'回扣比例'

3. 使用者可以點擊"新增"按鈕，跳出一個視窗來新增Rebate Setting，並在輸入完資料"確定"時新增Rebate Setting

4. 使用者點擊Rebate Setting列表某個Item右側的修改選項，跳出一個視窗來修改Rebate Setting，並在輸入完資料"確定"時修改Rebate Setting

5. Rebate Setting 的 Data Mode為
   interface RebateSettingData {
   id: number;
   productType: string;
   subProductType: string;
   systemName: string;
   subSystemName: string;
   commissionParameter: string;
   orderProduct: string;
   orderProductType: string;
   commissionRate: number;
   rebateRate: number;
   }

6. Rebate Setting 的 Controller Function為

RebateSettingControllerInterface {
function readRabteSettingList()//讀取Reabate Setting
function createRebateSetting(rebateSetting: RebateSetting)//建置 Reabate Setting
function updateRebateSetting(rebateSetting: RebateSetting)//更新 Reabate Setting
}

7. 請用MVVM開發，並將Model、View、ViewModel分開

Vibe Coding建立出來的範例: https://claude.ai/public/artifacts/c6a16844-0139-4404-b4c3-9eaa1ce1ade2
```

[代碼](./step3_code.md)


### 第四步
將頁面轉成Figma，讓UI可以根據Vibe Code畫出來的UI更省力

https://html.to.design/blog/from-claude-ai-to-figma

### 第五步
將Data Model轉成Table DDL
```
請根據下方RebateSetting的資料產生MySql Table DDL，table跟cloumn要小寫，id要bigint, commissionRate跟rebateRate要是Decimal到小數點第六位
interface RebateSettingData {
  id: number;
  productType: string;
  subProductType: string;
  systemName: string;
  subSystemName: string;
  commissionParameter: string;
  orderProduct: string;
  orderProductType: string;
  commissionRate: number;
  rebateRate: number;
}
```
[Table DDL](./step5_code.md)

### 第六步
將第五步產生的Table DDL轉成API代碼
```
請根據下方rebate_setting的DDL，用Springboot寫出CRUD的API，該Springboot專案有參照Lombok Liberary

1. rebate_setting的DDL
CREATE TABLE rebate_setting (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_type VARCHAR(255) NOT NULL,
    sub_product_type VARCHAR(255) NOT NULL,
    system_name VARCHAR(255) NOT NULL,
    sub_system_name VARCHAR(255) NOT NULL,
    commission_parameter VARCHAR(255) NOT NULL,
    order_product VARCHAR(255) NOT NULL,
    order_product_type VARCHAR(255) NOT NULL,
    commission_rate DECIMAL(12, 6) NOT NULL,
    rebate_rate DECIMAL(12, 6) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

2. 在CRUD情境中，每個API都是獨立的@Service，都用start function給Controller呼叫

3. 這些CRUD Service統一在一個@Controller

4. 用Springboot JPA做Table操作
```

[代碼](./step6_code.md)

# 概念
* ISP
* MVVM