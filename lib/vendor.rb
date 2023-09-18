class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    @inventory[item]
  end


  def stock(item, quantity)
    if @inventory[item].nil?
      @inventory[item] = quantity
    else
      @inventory[item] += quantity
    end
  end

  def potential_revenue
    rev = 0
    @inventory.each do |item|
      # require 'pry'; binding.pry
      rev += (item[0].price.gsub("$", "").to_f * item[1])
    end
    rev
  end
end