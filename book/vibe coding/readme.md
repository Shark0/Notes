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

#### 代碼
```
import React, { useState } from 'react';
import { Plus, Edit2, X } from 'lucide-react';

const RebateSettingManagement = () => {
  const [rebateSettings, setRebateSettings] = useState([
    {
      id: 1,
      productCategory: '電子產品',
      subProductType: '手機',
      systemName: 'Mobile System',
      subSystemName: 'iOS System',
      commissionParams: '標準參數',
      orderProduct: 'iPhone 15',
      productType: '智慧型手機',
      commissionRate: '5%',
      rebateRate: '2%'
    },
    {
      id: 2,
      productCategory: '家電',
      subProductType: '冰箱',
      systemName: 'Home Appliance System',
      subSystemName: 'Refrigerator System',
      commissionParams: '高級參數',
      orderProduct: '雙門冰箱',
      productType: '大型家電',
      commissionRate: '3%',
      rebateRate: '1.5%'
    }
  ]);

  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingItem, setEditingItem] = useState(null);
  const [formData, setFormData] = useState({
    productCategory: '',
    subProductType: '',
    systemName: '',
    subSystemName: '',
    commissionParams: '',
    orderProduct: '',
    productType: '',
    commissionRate: '',
    rebateRate: ''
  });

  const resetForm = () => {
    setFormData({
      productCategory: '',
      subProductType: '',
      systemName: '',
      subSystemName: '',
      commissionParams: '',
      orderProduct: '',
      productType: '',
      commissionRate: '',
      rebateRate: ''
    });
  };

  const openAddModal = () => {
    setEditingItem(null);
    resetForm();
    setIsModalOpen(true);
  };

  const openEditModal = (item) => {
    setEditingItem(item);
    setFormData({
      productCategory: item.productCategory,
      subProductType: item.subProductType,
      systemName: item.systemName,
      subSystemName: item.subSystemName,
      commissionParams: item.commissionParams,
      orderProduct: item.orderProduct,
      productType: item.productType,
      commissionRate: item.commissionRate,
      rebateRate: item.rebateRate
    });
    setIsModalOpen(true);
  };

  const closeModal = () => {
    setIsModalOpen(false);
    setEditingItem(null);
    resetForm();
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = () => {
    
    if (editingItem) {
      // 修改現有項目
      setRebateSettings(prev => prev.map(item => 
        item.id === editingItem.id 
          ? { ...formData, id: editingItem.id }
          : item
      ));
    } else {
      // 新增項目
      const newId = Math.max(...rebateSettings.map(item => item.id), 0) + 1;
      setRebateSettings(prev => [...prev, { ...formData, id: newId }]);
    }
    
    closeModal();
  };

  return (
    <div className="min-h-screen bg-gray-50 p-6">
      <div className="max-w-7xl mx-auto">
        {/* Header */}
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-3xl font-bold text-gray-900">Rebate Setting 管理</h1>
          <button
            onClick={openAddModal}
            className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg flex items-center gap-2 transition-colors"
          >
            <Plus size={20} />
            新增
          </button>
        </div>

        {/* Table */}
        <div className="bg-white rounded-lg shadow-md overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">產品類別</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">子產品類型</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">系統名稱</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">子系統名稱</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">傭金參數</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">訂單產品</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">產品類型</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">傭金比例</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">回扣比例</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">操作</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200">
                {rebateSettings.map((item) => (
                  <tr key={item.id} className="hover:bg-gray-50">
                    <td className="px-4 py-3 text-sm text-gray-900">{item.productCategory}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.subProductType}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.systemName}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.subSystemName}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.commissionParams}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.orderProduct}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.productType}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.commissionRate}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.rebateRate}</td>
                    <td className="px-4 py-3">
                      <button
                        onClick={() => openEditModal(item)}
                        className="text-blue-600 hover:text-blue-800 p-1 rounded transition-colors"
                        title="修改"
                      >
                        <Edit2 size={16} />
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        {/* Modal */}
        {isModalOpen && (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
            <div className="bg-white rounded-lg shadow-xl w-full max-w-2xl max-h-[90vh] overflow-y-auto">
              <div className="flex justify-between items-center p-6 border-b">
                <h2 className="text-xl font-semibold text-gray-900">
                  {editingItem ? '修改 Rebate Setting' : '新增 Rebate Setting'}
                </h2>
                <button
                  onClick={closeModal}
                  className="text-gray-400 hover:text-gray-600"
                >
                  <X size={24} />
                </button>
              </div>

              <div className="p-6">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      產品類別 *
                    </label>
                    <input
                      type="text"
                      name="productCategory"
                      value={formData.productCategory}
                      onChange={handleInputChange}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      子產品類型 *
                    </label>
                    <input
                      type="text"
                      name="subProductType"
                      value={formData.subProductType}
                      onChange={handleInputChange}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      系統名稱 *
                    </label>
                    <input
                      type="text"
                      name="systemName"
                      value={formData.systemName}
                      onChange={handleInputChange}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      子系統名稱 *
                    </label>
                    <input
                      type="text"
                      name="subSystemName"
                      value={formData.subSystemName}
                      onChange={handleInputChange}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      傭金參數 *
                    </label>
                    <input
                      type="text"
                      name="commissionParams"
                      value={formData.commissionParams}
                      onChange={handleInputChange}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      訂單產品 *
                    </label>
                    <input
                      type="text"
                      name="orderProduct"
                      value={formData.orderProduct}
                      onChange={handleInputChange}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      產品類型 *
                    </label>
                    <input
                      type="text"
                      name="productType"
                      value={formData.productType}
                      onChange={handleInputChange}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      傭金比例 *
                    </label>
                    <input
                      type="text"
                      name="commissionRate"
                      value={formData.commissionRate}
                      onChange={handleInputChange}
                      placeholder="例如: 5%"
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      回扣比例 *
                    </label>
                    <input
                      type="text"
                      name="rebateRate"
                      value={formData.rebateRate}
                      onChange={handleInputChange}
                      placeholder="例如: 2%"
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      required
                    />
                  </div>
                </div>

                <div className="flex justify-end gap-3 mt-6 pt-4 border-t">
                  <button
                    type="button"
                    onClick={closeModal}
                    className="px-4 py-2 text-gray-700 bg-gray-200 hover:bg-gray-300 rounded-md transition-colors"
                  >
                    取消
                  </button>
                  <button
                    type="button"
                    onClick={handleSubmit}
                    className="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-md transition-colors"
                  >
                    確定
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default RebateSettingManagement;
```

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

#### 代碼
```
import React, { useState, useEffect } from 'react';
import { Plus, Edit2, X } from 'lucide-react';

// Data Model Interface
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

// Controller Interface Implementation (Mock)
class RebateSettingController {
  private static data: RebateSettingData[] = [
    {
      id: 1,
      productType: '電子產品',
      subProductType: '手機',
      systemName: 'Mobile System',
      subSystemName: 'iOS System',
      commissionParameter: '標準參數',
      orderProduct: 'iPhone 15',
      orderProductType: '智慧型手機',
      commissionRate: 5.0,
      rebateRate: 2.0
    },
    {
      id: 2,
      productType: '家電',
      subProductType: '冰箱',
      systemName: 'Home Appliance System',
      subSystemName: 'Refrigerator System',
      commissionParameter: '高級參數',
      orderProduct: '雙門冰箱',
      orderProductType: '大型家電',
      commissionRate: 3.0,
      rebateRate: 1.5
    }
  ];

  static readRebateSettingList(): Promise<RebateSettingData[]> {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve([...this.data]);
      }, 300);
    });
  }

  static createRebateSetting(rebateSetting: Omit<RebateSettingData, 'id'>): Promise<RebateSettingData> {
    return new Promise((resolve) => {
      setTimeout(() => {
        const newId = Math.max(...this.data.map(item => item.id), 0) + 1;
        const newRebateSetting = { ...rebateSetting, id: newId };
        this.data.push(newRebateSetting);
        resolve(newRebateSetting);
      }, 300);
    });
  }

  static updateRebateSetting(rebateSetting: RebateSettingData): Promise<RebateSettingData> {
    return new Promise((resolve) => {
      setTimeout(() => {
        const index = this.data.findIndex(item => item.id === rebateSetting.id);
        if (index !== -1) {
          this.data[index] = rebateSetting;
        }
        resolve(rebateSetting);
      }, 300);
    });
  }
}

const RebateSettingManagement = () => {
  const [rebateSettings, setRebateSettings] = useState<RebateSettingData[]>([]);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<RebateSettingData | null>(null);
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState<Omit<RebateSettingData, 'id'>>({
    productType: '',
    subProductType: '',
    systemName: '',
    subSystemName: '',
    commissionParameter: '',
    orderProduct: '',
    orderProductType: '',
    commissionRate: 0,
    rebateRate: 0
  });

  // 載入Rebate Setting列表
  const loadRebateSettings = async () => {
    setLoading(true);
    try {
      const data = await RebateSettingController.readRebateSettingList();
      setRebateSettings(data);
    } catch (error) {
      console.error('載入資料失敗:', error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadRebateSettings();
  }, []);

  const resetForm = () => {
    setFormData({
      productType: '',
      subProductType: '',
      systemName: '',
      subSystemName: '',
      commissionParameter: '',
      orderProduct: '',
      orderProductType: '',
      commissionRate: 0,
      rebateRate: 0
    });
  };

  const openAddModal = () => {
    setEditingItem(null);
    resetForm();
    setIsModalOpen(true);
  };

  const openEditModal = (item: RebateSettingData) => {
    setEditingItem(item);
    setFormData({
      productType: item.productType,
      subProductType: item.subProductType,
      systemName: item.systemName,
      subSystemName: item.subSystemName,
      commissionParameter: item.commissionParameter,
      orderProduct: item.orderProduct,
      orderProductType: item.orderProductType,
      commissionRate: item.commissionRate,
      rebateRate: item.rebateRate
    });
    setIsModalOpen(true);
  };

  const closeModal = () => {
    setIsModalOpen(false);
    setEditingItem(null);
    resetForm();
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: name === 'commissionRate' || name === 'rebateRate' 
        ? parseFloat(value) || 0 
        : value
    }));
  };

  const handleSubmit = async () => {
    setLoading(true);
    try {
      if (editingItem) {
        // 更新現有項目
        await RebateSettingController.updateRebateSetting({
          ...formData,
          id: editingItem.id
        });
      } else {
        // 建立新項目
        await RebateSettingController.createRebateSetting(formData);
      }
      
      // 重新載入列表
      await loadRebateSettings();
      closeModal();
    } catch (error) {
      console.error('儲存失敗:', error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 p-6">
      <div className="max-w-7xl mx-auto">
        {/* Header */}
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-3xl font-bold text-gray-900">Rebate Setting 管理</h1>
          <button
            onClick={openAddModal}
            disabled={loading}
            className="bg-blue-600 hover:bg-blue-700 disabled:bg-blue-400 text-white px-4 py-2 rounded-lg flex items-center gap-2 transition-colors"
          >
            <Plus size={20} />
            新增
          </button>
        </div>

        {/* Loading Indicator */}
        {loading && (
          <div className="flex justify-center items-center py-8">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
            <span className="ml-2 text-gray-600">載入中...</span>
          </div>
        )}

        {/* Table */}
        <div className="bg-white rounded-lg shadow-md overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">產品類別</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">子產品類型</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">系統名稱</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">子系統名稱</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">傭金參數</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">訂單產品</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">訂單產品類型</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">傭金比例</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">回扣比例</th>
                  <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">操作</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200">
                {rebateSettings.map((item) => (
                  <tr key={item.id} className="hover:bg-gray-50">
                    <td className="px-4 py-3 text-sm text-gray-900">{item.productType}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.subProductType}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.systemName}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.subSystemName}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.commissionParameter}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.orderProduct}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.orderProductType}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.commissionRate}%</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.rebateRate}%</td>
                    <td className="px-4 py-3">
                      <button
                        onClick={() => openEditModal(item)}
                        disabled={loading}
                        className="text-blue-600 hover:text-blue-800 disabled:text-blue-400 p-1 rounded transition-colors"
                        title="修改"
                      >
                        <Edit2 size={16} />
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        {/* Modal */}
        {isModalOpen && (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
            <div className="bg-white rounded-lg shadow-xl w-full max-w-2xl max-h-[90vh] overflow-y-auto">
              <div className="flex justify-between items-center p-6 border-b">
                <h2 className="text-xl font-semibold text-gray-900">
                  {editingItem ? '修改 Rebate Setting' : '新增 Rebate Setting'}
                </h2>
                <button
                  onClick={closeModal}
                  disabled={loading}
                  className="text-gray-400 hover:text-gray-600 disabled:text-gray-300"
                >
                  <X size={24} />
                </button>
              </div>

              <div className="p-6">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      產品類別 *
                    </label>
                    <input
                      type="text"
                      name="productType"
                      value={formData.productType}
                      onChange={handleInputChange}
                      disabled={loading}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:bg-gray-100"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      子產品類型 *
                    </label>
                    <input
                      type="text"
                      name="subProductType"
                      value={formData.subProductType}
                      onChange={handleInputChange}
                      disabled={loading}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:bg-gray-100"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      系統名稱 *
                    </label>
                    <input
                      type="text"
                      name="systemName"
                      value={formData.systemName}
                      onChange={handleInputChange}
                      disabled={loading}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:bg-gray-100"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      子系統名稱 *
                    </label>
                    <input
                      type="text"
                      name="subSystemName"
                      value={formData.subSystemName}
                      onChange={handleInputChange}
                      disabled={loading}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:bg-gray-100"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      傭金參數 *
                    </label>
                    <input
                      type="text"
                      name="commissionParameter"
                      value={formData.commissionParameter}
                      onChange={handleInputChange}
                      disabled={loading}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:bg-gray-100"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      訂單產品 *
                    </label>
                    <input
                      type="text"
                      name="orderProduct"
                      value={formData.orderProduct}
                      onChange={handleInputChange}
                      disabled={loading}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:bg-gray-100"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      訂單產品類型 *
                    </label>
                    <input
                      type="text"
                      name="orderProductType"
                      value={formData.orderProductType}
                      onChange={handleInputChange}
                      disabled={loading}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:bg-gray-100"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      傭金比例 (%) *
                    </label>
                    <input
                      type="number"
                      name="commissionRate"
                      value={formData.commissionRate}
                      onChange={handleInputChange}
                      disabled={loading}
                      step="0.1"
                      min="0"
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:bg-gray-100"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      回扣比例 (%) *
                    </label>
                    <input
                      type="number"
                      name="rebateRate"
                      value={formData.rebateRate}
                      onChange={handleInputChange}
                      disabled={loading}
                      step="0.1"
                      min="0"
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:bg-gray-100"
                      required
                    />
                  </div>
                </div>

                <div className="flex justify-end gap-3 mt-6 pt-4 border-t">
                  <button
                    type="button"
                    onClick={closeModal}
                    disabled={loading}
                    className="px-4 py-2 text-gray-700 bg-gray-200 hover:bg-gray-300 disabled:bg-gray-100 rounded-md transition-colors"
                  >
                    取消
                  </button>
                  <button
                    type="button"
                    onClick={handleSubmit}
                    disabled={loading}
                    className="px-4 py-2 bg-blue-600 hover:bg-blue-700 disabled:bg-blue-400 text-white rounded-md transition-colors flex items-center gap-2"
                  >
                    {loading && <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>}
                    確定
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default RebateSettingManagement;
```



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

#### 代碼
```
import React, { useState, useEffect } from 'react';
import { Plus, Edit, X } from 'lucide-react';

// Model - 資料模型定義
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

// Model - Controller Interface
interface RebateSettingControllerInterface {
  readRabteSettingList(): Promise<RebateSettingData[]>;
  createRebateSetting(rebateSetting: RebateSettingData): Promise<RebateSettingData>;
  updateRebateSetting(rebateSetting: RebateSettingData): Promise<RebateSettingData>;
}

// Model - 模擬的資料服務
class RebateSettingService implements RebateSettingControllerInterface {
  private mockData: RebateSettingData[] = [
    {
      id: 1,
      productType: '金融商品',
      subProductType: '基金',
      systemName: '交易系統A',
      subSystemName: '基金交易子系統',
      commissionParameter: '標準費率',
      orderProduct: '台股基金',
      orderProductType: '股票型',
      commissionRate: 0.015,
      rebateRate: 0.005
    },
    {
      id: 2,
      productType: '保險商品',
      subProductType: '壽險',
      systemName: '保險系統B',
      subSystemName: '壽險處理子系統',
      commissionParameter: '高級費率',
      orderProduct: '終身壽險',
      orderProductType: '保障型',
      commissionRate: 0.025,
      rebateRate: 0.008
    }
  ];

  async readRabteSettingList(): Promise<RebateSettingData[]> {
    // 模擬API呼叫延遲
    await new Promise(resolve => setTimeout(resolve, 300));
    return [...this.mockData];
  }

  async createRebateSetting(rebateSetting: RebateSettingData): Promise<RebateSettingData> {
    await new Promise(resolve => setTimeout(resolve, 300));
    const newSetting = { ...rebateSetting, id: Date.now() };
    this.mockData.push(newSetting);
    return newSetting;
  }

  async updateRebateSetting(rebateSetting: RebateSettingData): Promise<RebateSettingData> {
    await new Promise(resolve => setTimeout(resolve, 300));
    const index = this.mockData.findIndex(item => item.id === rebateSetting.id);
    if (index !== -1) {
      this.mockData[index] = rebateSetting;
    }
    return rebateSetting;
  }
}

// ViewModel - 業務邏輯層
class RebateSettingViewModel {
  private service: RebateSettingService;
  private listeners: Set<() => void> = new Set();

  constructor() {
    this.service = new RebateSettingService();
  }

  subscribe(listener: () => void) {
    this.listeners.add(listener);
    return () => this.listeners.delete(listener);
  }

  private notify() {
    this.listeners.forEach(listener => listener());
  }

  async loadRebateSettings(): Promise<RebateSettingData[]> {
    try {
      return await this.service.readRabteSettingList();
    } catch (error) {
      console.error('載入Rebate Settings失敗:', error);
      throw error;
    }
  }

  async createRebateSetting(formData: Omit<RebateSettingData, 'id'>): Promise<RebateSettingData> {
    try {
      const newSetting = await this.service.createRebateSetting({
        ...formData,
        id: 0 // 會在service中重新分配
      });
      this.notify();
      return newSetting;
    } catch (error) {
      console.error('建立Rebate Setting失敗:', error);
      throw error;
    }
  }

  async updateRebateSetting(rebateSetting: RebateSettingData): Promise<RebateSettingData> {
    try {
      const updatedSetting = await this.service.updateRebateSetting(rebateSetting);
      this.notify();
      return updatedSetting;
    } catch (error) {
      console.error('更新Rebate Setting失敗:', error);
      throw error;
    }
  }

  validateFormData(formData: Partial<RebateSettingData>): string[] {
    const errors: string[] = [];
    
    if (!formData.productType?.trim()) errors.push('產品類別為必填項目');
    if (!formData.subProductType?.trim()) errors.push('子產品類型為必填項目');
    if (!formData.systemName?.trim()) errors.push('系統名稱為必填項目');
    if (!formData.subSystemName?.trim()) errors.push('子系統名稱為必填項目');
    if (!formData.commissionParameter?.trim()) errors.push('傭金參數為必填項目');
    if (!formData.orderProduct?.trim()) errors.push('訂單產品為必填項目');
    if (!formData.orderProductType?.trim()) errors.push('訂單產品類型為必填項目');
    
    if (formData.commissionRate !== undefined && (formData.commissionRate < 0 || formData.commissionRate > 1)) {
      errors.push('傭金比例必須在0到1之間');
    }
    if (formData.rebateRate !== undefined && (formData.rebateRate < 0 || formData.rebateRate > 1)) {
      errors.push('回扣比例必須在0到1之間');
    }

    return errors;
  }
}

// View Components
const RebateSettingForm: React.FC<{
  isOpen: boolean;
  onClose: () => void;
  onSubmit: (data: Omit<RebateSettingData, 'id'> | RebateSettingData) => Promise<void>;
  initialData?: RebateSettingData;
  title: string;
}> = ({ isOpen, onClose, onSubmit, initialData, title }) => {
  const [formData, setFormData] = useState<Partial<RebateSettingData>>({
    productType: '',
    subProductType: '',
    systemName: '',
    subSystemName: '',
    commissionParameter: '',
    orderProduct: '',
    orderProductType: '',
    commissionRate: 0,
    rebateRate: 0
  });
  const [errors, setErrors] = useState<string[]>([]);
  const [isSubmitting, setIsSubmitting] = useState(false);

  useEffect(() => {
    if (initialData) {
      setFormData(initialData);
    } else {
      setFormData({
        productType: '',
        subProductType: '',
        systemName: '',
        subSystemName: '',
        commissionParameter: '',
        orderProduct: '',
        orderProductType: '',
        commissionRate: 0,
        rebateRate: 0
      });
    }
    setErrors([]);
  }, [initialData, isOpen]);

  const handleSubmit = async () => {
    
    const viewModel = new RebateSettingViewModel();
    const validationErrors = viewModel.validateFormData(formData);
    
    if (validationErrors.length > 0) {
      setErrors(validationErrors);
      return;
    }

    setIsSubmitting(true);
    try {
      await onSubmit(formData as any);
      onClose();
    } catch (error) {
      setErrors(['操作失敗，請稍後再試']);
    } finally {
      setIsSubmitting(false);
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div className="bg-white rounded-lg p-6 w-full max-w-2xl max-h-[90vh] overflow-y-auto">
        <div className="flex justify-between items-center mb-4">
          <h3 className="text-lg font-semibold">{title}</h3>
          <button
            onClick={onClose}
            className="text-gray-500 hover:text-gray-700"
            disabled={isSubmitting}
          >
            <X size={24} />
          </button>
        </div>

        {errors.length > 0 && (
          <div className="mb-4 p-3 bg-red-100 border border-red-300 rounded text-red-700">
            <ul className="list-disc list-inside">
              {errors.map((error, index) => (
                <li key={index}>{error}</li>
              ))}
            </ul>
          </div>
        )}

        <div className="space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                產品類別 <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                value={formData.productType || ''}
                onChange={(e) => setFormData({...formData, productType: e.target.value})}
                className="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                disabled={isSubmitting}
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                子產品類型 <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                value={formData.subProductType || ''}
                onChange={(e) => setFormData({...formData, subProductType: e.target.value})}
                className="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                disabled={isSubmitting}
              />
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                系統名稱 <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                value={formData.systemName || ''}
                onChange={(e) => setFormData({...formData, systemName: e.target.value})}
                className="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                disabled={isSubmitting}
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                子系統名稱 <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                value={formData.subSystemName || ''}
                onChange={(e) => setFormData({...formData, subSystemName: e.target.value})}
                className="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                disabled={isSubmitting}
              />
            </div>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              傭金參數 <span className="text-red-500">*</span>
            </label>
            <input
              type="text"
              value={formData.commissionParameter || ''}
              onChange={(e) => setFormData({...formData, commissionParameter: e.target.value})}
              className="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              disabled={isSubmitting}
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                訂單產品 <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                value={formData.orderProduct || ''}
                onChange={(e) => setFormData({...formData, orderProduct: e.target.value})}
                className="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                disabled={isSubmitting}
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                訂單產品類型 <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                value={formData.orderProductType || ''}
                onChange={(e) => setFormData({...formData, orderProductType: e.target.value})}
                className="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                disabled={isSubmitting}
              />
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                傭金比例 <span className="text-red-500">*</span>
              </label>
              <input
                type="number"
                step="0.001"
                min="0"
                max="1"
                value={formData.commissionRate || 0}
                onChange={(e) => setFormData({...formData, commissionRate: parseFloat(e.target.value) || 0})}
                className="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                disabled={isSubmitting}
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                回扣比例 <span className="text-red-500">*</span>
              </label>
              <input
                type="number"
                step="0.001"
                min="0"
                max="1"
                value={formData.rebateRate || 0}
                onChange={(e) => setFormData({...formData, rebateRate: parseFloat(e.target.value) || 0})}
                className="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                disabled={isSubmitting}
              />
            </div>
          </div>

          <div className="flex justify-end space-x-2 pt-4">
            <button
              type="button"
              onClick={onClose}
              className="px-4 py-2 text-gray-600 border border-gray-300 rounded hover:bg-gray-50"
              disabled={isSubmitting}
            >
              取消
            </button>
            <button
              type="button"
              onClick={handleSubmit}
              className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 disabled:opacity-50"
              disabled={isSubmitting}
            >
              {isSubmitting ? '處理中...' : '確定'}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

// Main View Component
const RebateSettingManager: React.FC = () => {
  const [rebateSettings, setRebateSettings] = useState<RebateSettingData[]>([]);
  const [loading, setLoading] = useState(true);
  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<RebateSettingData | null>(null);
  
  const viewModel = new RebateSettingViewModel();

  const loadData = async () => {
    setLoading(true);
    try {
      const data = await viewModel.loadRebateSettings();
      setRebateSettings(data);
    } catch (error) {
      console.error('載入資料失敗:', error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadData();
  }, []);

  const handleCreate = async (formData: Omit<RebateSettingData, 'id'>) => {
    await viewModel.createRebateSetting(formData);
    await loadData();
  };

  const handleUpdate = async (formData: RebateSettingData) => {
    await viewModel.updateRebateSetting(formData);
    await loadData();
  };

  const handleEdit = (item: RebateSettingData) => {
    setEditingItem(item);
    setIsEditModalOpen(true);
  };

  if (loading) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="text-lg text-gray-600">載入中...</div>
      </div>
    );
  }

  return (
    <div className="p-6 max-w-7xl mx-auto">
      <div className="mb-6 flex justify-between items-center">
        <h1 className="text-2xl font-bold text-gray-900">Rebate Setting 管理</h1>
        <button
          onClick={() => setIsCreateModalOpen(true)}
          className="flex items-center space-x-2 bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"
        >
          <Plus size={20} />
          <span>新增</span>
        </button>
      </div>

      <div className="bg-white rounded-lg shadow overflow-hidden">
        <div className="overflow-x-auto">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">產品類別</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">子產品類型</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">系統名稱</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">子系統名稱</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">傭金參數</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">訂單產品</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">訂單產品類型</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">傭金比例</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">回扣比例</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {rebateSettings.map((item) => (
                <tr key={item.id} className="hover:bg-gray-50">
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{item.productType}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{item.subProductType}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{item.systemName}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{item.subSystemName}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{item.commissionParameter}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{item.orderProduct}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{item.orderProductType}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{(item.commissionRate * 100).toFixed(1)}%</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{(item.rebateRate * 100).toFixed(1)}%</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                    <button
                      onClick={() => handleEdit(item)}
                      className="text-blue-600 hover:text-blue-900 flex items-center space-x-1"
                    >
                      <Edit size={16} />
                      <span>修改</span>
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {rebateSettings.length === 0 && (
          <div className="text-center py-12 text-gray-500">
            目前沒有任何 Rebate Setting 資料
          </div>
        )}
      </div>

      <RebateSettingForm
        isOpen={isCreateModalOpen}
        onClose={() => setIsCreateModalOpen(false)}
        onSubmit={handleCreate}
        title="新增 Rebate Setting"
      />

      <RebateSettingForm
        isOpen={isEditModalOpen}
        onClose={() => {
          setIsEditModalOpen(false);
          setEditingItem(null);
        }}
        onSubmit={handleUpdate}
        initialData={editingItem || undefined}
        title="修改 Rebate Setting"
      />
    </div>
  );
};

export default RebateSettingManager;
```

# 概念
* ISP
* MVVM