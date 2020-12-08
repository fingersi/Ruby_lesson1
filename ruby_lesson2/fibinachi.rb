

puts ''
puts 'Заполнить массив числами фибоначчи до 100'
puts ''

fibonacci_array = [0,1]

index = 1

puts 'Числа Фибоначчи до 100'

loop do

  temp = fibonacci_array[index -1] + fibonacci_array[index]
  if temp < 100
    fibonacci_array[index + 1] = temp
    puts fibonacci_array[index + 1]
    index += 1
  else
    break
  end
end