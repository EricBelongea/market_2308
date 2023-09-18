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

  # def potential_revenue
  #   revenue = 0

  #   @inventory.each do |item|
  #     item[:price] * 
  #   end
  # end
end