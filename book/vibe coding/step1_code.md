# Step1 Code
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