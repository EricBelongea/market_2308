require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe '#Market' do
  before(:each) do
    @market = Market.new("South Pearl Street Farmers Market") 

    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")

    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end
  describe '#Existance' do
    it 'exists with attributes' do
      expect(@market).to be_instance_of Market

      expect(@market.name).to eq("South Pearl Street Farmers Market")
      expect(@market.vendors).to eq([])
    end
  end

  describe '#Can add vendors and their items' do
    it 'vendors can add items' do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      expect(@vendor1.inventory).to eq({@item1 => 35, @item2 => 7})
      
      @vendor2.stock(@item4, 50)    
      @vendor2.stock(@item3, 25)
      expect(@vendor2.inventory).to eq({@item4 => 50, @item3 => 25})
      
      @vendor3.stock(@item1, 65) 
      expect(@vendor3.inventory).to eq({@item1 => 65})
    end

    it 'markets have vendors' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end

    it 'list vendor names' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      # require 'pry'; binding.pry
      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it 'who has said items' do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50) 
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)

      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
      expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
    end
  end

  describe '#Vendor Revenue' do
    it 'can calculate revenue' do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50) 
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)

      expect(@vendor1.potential_revenue).to eq(29.75)
      expect(@vendor3.potential_revenue).to eq(48.75)
    end
  end

  describe '#sorted items' do
    it 'lists item alphabetically and uniq' do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50) 
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)

      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
    end
  end

  describe '#Total Inventory' do
    it 'has a running total' do 
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50) 
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)

      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.total_inventory[@item1]).to eq({quantity: 100, vendors: [@vendor1, @vendor3]})
      expect(@market.total_inventory[@item2]).to eq({quantity: 7, vendors: [@vendor1]})
    end
  end

  describe '#Overstocked items' do
    it 'has overstocked items' do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50) 
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)

      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.overstocked_items).to eq([@item1])
    end
  end
end