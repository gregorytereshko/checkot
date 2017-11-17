require "rspec"
require_relative '../lib/checkout'

describe Checkout do
  cola = CC.new(title: 'Кока-кола', price: 1.5)
  pepsi = PC.new(title: 'Пепси-кола', price: 2.0)
  water = WA.new(title: 'Вода', price: 0.85)
  pricing_rules = []
  pricing_rules << PricingRule.new(item_type: 'PC', items_neded: 3, sale: 20, extra_one: false)
  pricing_rules << PricingRule.new(item_type: 'CC', items_neded: 1, sale: 50, extra_one: true)
  co = Checkout.new(pricing_rules: pricing_rules)

  before(:each) do
    co.items = {}
  end

  it "should can add an item to checkout" do
    co.add pepsi

    expect(co.items.keys).to include(pepsi.code)
  end

  it "should increments items collection counter" do
    expect{
      co.add(pepsi)
      co.add(cola)
      co.add(water)
    }.to change{co.items_count}.by(3)
  end

  context 'calculate right total' do

    it "with three diffrent items" do
      co.add(pepsi)
      co.add(cola)
      co.add(water)

      expect(co.total).to equal(4.35)
    end

    it "with one extra cola" do
      co.add(cola)
      co.add(pepsi)
      co.add(cola)
      co.add(cola)

      expect(co.total).to equal(5.0)
    end

    it "with one extra cola and pepsi discount" do
      co.add(pepsi)
      co.add(cola)
      co.add(pepsi)
      co.add(water)
      co.add(pepsi)
      co.add(cola)

      expect(co.total).to equal(7.15)
    end

  end

end
