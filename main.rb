require_relative 'lib/checkout'

cola = CC.new(title: 'Кока-кола', price: 1.5)
pepsi = PC.new(title: 'Пепси-кола', price: 2.0)
water = WA.new(title: 'Вода', price: 0.85)

pricing_rules = []
pricing_rules << PricingRule.new(item_type: 'PC', items_neded: 3, sale: 20, extra_one: false)
pricing_rules << PricingRule.new(item_type: 'CC', items_neded: 1, sale: 50, extra_one: true)

co = Checkout.new(pricing_rules: pricing_rules)

co.add pepsi
co.add cola
co.add pepsi
co.add water
co.add pepsi
co.add cola

p co.total
