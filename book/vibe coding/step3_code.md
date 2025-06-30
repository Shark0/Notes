# Step3 Code
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