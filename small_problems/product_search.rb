PRODUCTS = [
  { name: 'ThinkPad 202', price: 220 },
  { name: 'ThinkPad 205', price: 300 },
  { name: 'ThinkPad 210', price: 400 },
  { name: 'Dell 156', price: 300 }
].freeze

query = {
  price_min: 240,
  price_max: 320,
  q: 'think'
}

def search(query)
  price_min = query[:price_min]
  price_max = query[:price_max]
  PRODUCTS.select do |product|
    product[:price] <= price_max &&
      product[:price] >= price_min &&
      product[:name].downcase.include?(query[:q])
  end
end

p search(query)
