class Item
  attr_accessor :title, :price, :code

  def initialize(args)
    @title = args[:title]
    @price = args[:price]
  end

  def code
    ''
  end

end
