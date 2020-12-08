
puts ''
puts  'Заполнить массив числами от 10 до 100 с шагом 5'
puts ''

puts "Получившийся массив"

(10..100).step(5).to_a.each{|index| puts index}