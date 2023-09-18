require './lib/item'
require './lib/vendor'

RSpec.describe '#Vendor' do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end
  describe '#Existance' do
    it 'exists with attributes' do
      expect(@vendor).to be_instance_of Vendor

      expect(@vendor.name).to eq('Rocky Mountain Fresh')
      expect(@vendor.inventory).to eq({})
    end
  end

  describe '#Vendor Stock' do
    it 'can check stock' do
      expect(@vendor.check_stock(@item1)).to eq(nil)
    end

    it 'can add stock to inventory' do
      @vendor.stock(@item1, 30)

      expect(@vendor.inventory).to eq({@item1 => 30})

      expect(@vendor.check_stock(@item1)).to eq(30)
    end

    it 'can add same item more than once' do
      @vendor.stock(@item1, 30)

      @vendor.stock(@item1, 25)

      expect(@vendor.check_stock(@item1)).to eq(55)
    end

    it 'has multiple items' do
      @vendor.stock(@item1, 30)
      @vendor.stock(@item1, 25)
      
      @vendor.stock(@item2, 12)

      expect(@vendor.check_stock(@item1)).to eq(55)
      expect(@vendor.inventory).to eq({@item1 => 55, @item2 => 12})
    end
  end
end