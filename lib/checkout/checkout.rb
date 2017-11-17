class Checkout
  attr_accessor :items, :pricing_rules

  def initialize(args)
    @items = {}
    @pricing_rules = args[:pricing_rules] || []
  end

  def add item
    if @items[item.code]
      suitable_rule = @pricing_rules.select{ |pr| pr.item_type == item.code }.first
      add_item_with_rule(item, suitable_rule)
    else
      add_item item
    end
  end

  def total
    @items.values.map{ |info| info[:price] }.inject(0, :+).round(2)
  end

  def items_count
    @items.values.map{ |info| info[:count] }.inject(0, :+)
  end

  private

  def add_item item
    @items[item.code] = {}
    @items[item.code][:count] = 1
    @items[item.code][:price] = item.price
  end

  def add_item_with_rule item, rule
    @items[item.code][:count] += 1
    @items[item.code][:price] = if rule
                                  rule.apply_sale(item, @items)
                                else
                                  item.price * @items[item.code][:count]
                                end


  end

end
