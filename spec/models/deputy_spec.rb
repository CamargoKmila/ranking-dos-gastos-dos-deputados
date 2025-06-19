require 'rails_helper'

RSpec.describe Deputy, type: :model do
  subject { build(:deputy) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without txNomeParlamentar' do
      subject.txNomeParlamentar = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without sgPartido' do
      subject.sgPartido = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without sgUF' do
      subject.sgUF = nil
      expect(subject).not_to be_valid
    end
  end
end
