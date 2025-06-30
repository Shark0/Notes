# Step2 Code
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