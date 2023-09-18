class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    names = @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    sellers = []
    
    @vendors.map do |vendor|
      if vendor.inventory.include?(item) == true
        sellers << vendor
      end
    end

    sellers
  end

  def sorted_item_list
    list = []
    # require 'pry'; binding.pry
    @vendors.map do |vendor|
      vendor.inventory.each do |item|
        list << item[0].name
      end
    end

    list.sort.uniq
  end

  def total_inventory
    hash = {:item => {quantity: 0, vendors: []}}

    @vendors.map do |vendor|
      vendor.inventory.each do |item|
        hash[item] = item[0].name
        require 'pry'; binding.pry
        hash[item][:quantity] += item[1]
        hash[item][:vendors] << vendor
      end
    end

    hash.uniq
  end
end