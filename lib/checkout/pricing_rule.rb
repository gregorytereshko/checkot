class PricingRule
  attr_accessor :item_type, :sale, :extra_one, :items_neded

  def initialize(args)
    @item_type = args[:item_type]
    @sale = args[:sale]
    @extra_one = args[:extra_one]
    @items_neded = args[:items_neded]
  end

  def apply_sale item, line_items
    if @extra_one
      add_with_extra item, line_items
    else
      discount item, line_items
    end
  end

  private

  def add_with_extra item, line_items
    unless (line_items[item.code][:count] % (@items_neded + 1)).zero?
      line_items[item.code][:price] += item.price
    end
    line_items[item.code][:price]
  end

  def discount item, line_items
    if line_items[item.code][:count] >= @items_neded
      (item.price - item.price * @sale / 100) * line_items[item.code][:count]
    else
      item.price * line_items[item.code][:count]
    end
  end

end
