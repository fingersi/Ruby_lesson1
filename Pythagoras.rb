puts 'Введите длину стороны A.'
side_a = gets.chomp.to_f

puts 'Введите длину стороны B.'
side_b = gets.chomp.to_f

puts 'Введите длину стороны C.'
side_c = gets.chomp.to_f


if side_a == side_b && side_a == side_c
  puts 'У вас равносторонний треугольник.'

elsif side_a == side_b || side_a == side_c || side_b == side_c
  puts 'У Вас равнобедренный треугольник'

else 
  hypotenuse = [side_a, side_b, side_c].max

  puts hypotenuse

  if side_a == hypotenuse
    hypotenuse = side_a
    hypotenuse_name = 'сторона А'
    leg_sum = side_b ** 2 + side_c ** 2

  elsif side_b == hypotenuse
    hypotenuseName = 'сторона B'
    leg_sum = side_a ** 2 + side_c ** 2

  else side_c == hypotenuse
    hypotenuseName = 'сторона С'
    leg_sum = side_a ** 2 + side_b ** 2
  end

  puts "Гипотинуза: #{hypotenuseName} ее длина #{hypotenuse}"

  if hypotenuse == Math.sqrt(leg_sum)
    puts 'У вас прямоугольный треугольник'

  else
    puts 'У вас не прямоугольный треугольник'

  end
end