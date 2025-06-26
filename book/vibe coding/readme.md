# Vibe Coding

工具: https://claude.ai/

## 實作

### 第一步

可由讓PM敘述專案需求Prompt，來產出一個範例跟UI、RD講解需求，我拿公司要開發的Affiliate Store Rebate Setting來實驗
```
我想建置一個Rebate Setting管理頁面

1. 頁面一進去可以看到Rebate Setting列表

2. Rebate Setting的資料有'產品類別'、'子產品類型'、'系統名稱'、'子系統名稱'、'傭金參數'、'訂單產品'、'產品類型'、'傭金比例'、'回扣比例'

3. 使用者可以點擊"新增"按鈕，跳出一個視窗來新增Rebate Setting，並在輸入完資料"確定"時新增Rebate Setting

4. 使用者點擊Rebate Setting列表某個Item右側的修改選項，跳出一個視窗來修改Rebate Setting，並在輸入完資料"確定"時修改Rebate Setting
```

Vibe Coding建立出來的範例: https://claude.ai/public/artifacts/45da92fd-38a8-4443-9e20-2d70a430ada1

### 第二步

RD定義Data Model跟Function Interface，多定義第五點跟第六點
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

若之後後端開發出API，前端只要替換將資料處理有關的Function替換成API代碼的就好，這邊我是融合MVVM + ISP的概念。

### 第三步

要求MVVM，解耦Model、View、ViewModel，寫在第七點
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

若有能事先定義好Model並用MVVM開發，就能直接將範例的UI做替換，並用最少的工來將View綁定Model

# 概念
* ISP
* MVVM