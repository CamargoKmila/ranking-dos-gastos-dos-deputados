require 'rails_helper'

RSpec.describe Cost, type: :model do
  let(:deputy) { create(:deputy) }

  describe 'associations' do
    it 'belongs to a deputy' do
      cost = create(:cost, deputy: deputy)
      expect(cost.deputy).to eq(deputy)
    end
  end

  describe 'validations' do
    it 'is invalid without datEmissao' do
      cost = build(:cost, datEmissao: nil)
      expect(cost).to_not be_valid
      expect(cost.errors[:datEmissao]).to include("can't be blank")
    end

    it 'is invalid if vlrLiquido is not a number' do
      cost = build(:cost, vlrLiquido: 'abc')
      expect(cost).to_not be_valid
      expect(cost.errors[:vlrLiquido]).to include('is not a number')
    end
  end

  describe '.total_cost' do
    it 'returns the total sum of vlrLiquido' do
      create(:cost, vlrLiquido: 100, deputy: deputy)
      create(:cost, vlrLiquido: 200, deputy: deputy)
      expect(Cost.total_cost).to eq(300)
    end
  end

  describe '.max_cost' do
    it 'returns the cost with the highest vlrLiquido' do
      low = create(:cost, vlrLiquido: 50, deputy: deputy)
      high = create(:cost, vlrLiquido: 150, deputy: deputy)
      expect(Cost.max_cost).to eq(high)
    end
  end
end
