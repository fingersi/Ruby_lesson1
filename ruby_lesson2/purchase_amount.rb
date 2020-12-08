puts 'Программа рассчета стоимости покупок'
puts 'Вам будет предложено ввести свои покупки по следующему принципе:'
puts 'Сначало вводиться название товара, потом кол-во, потом стоимость за единицу.'
puts 'Вы можете ввести любое кол-во товаров, после ввода последнего купленного товара'
puts 'Введите слово "stop" для расчета стоимости покупок и завершения программы.'

shopping_list = {}

loop do
  puts 'Введите название товара.'
  input_name = gets.chomp
  break if input_name == 'stop'
  puts 'Введите кол-во купленного товара.В следующем формате X.X'
  input_quantity = gets.chomp
  break if input_quantity == 'stop'
  puts 'Введите цену за единицу товара. В следующем формате X.X'
  input_price = gets.chomp
  break if input_price == 'stop'

  if input_quantity.scan(/^([0-9]*\.[0-9]+)$/).any? && input_price.scan(/^([0-9]*\.[0-9]+)$/).any?
    shopping_list[input_name] = {qty: input_quantity.to_f, price: input_price.to_f }
    puts "В список покупок введен следующий товар"
    puts "Название #{input_name}"
    puts "Кол-во: #{shopping_list[input_name][:qty]}, Цена #{shopping_list[input_name][:price]}"
  else
    puts 'Вы ввели не правильные данные повторите ввод.'
  end
end

total_sum = 0

puts 'В вашем списке покупок следующие товары:'
shopping_list.each do |name, hash|
  puts "Название #{name}, Кол-во: #{hash[:qty]}, Цена: #{hash[:price]}"
  total_sum += hash[:price] * hash[:qty]
end

puts "Cумма всех покупок: #{total_sum }"