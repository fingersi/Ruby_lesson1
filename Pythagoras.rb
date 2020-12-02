puts 'Введите длину стороны A.'
sideA = gets.chomp.to_i

puts 'Введите длину стороны B.'
sideB = gets.chomp.to_i

puts 'Введите длину стороны C.'
sideC = gets.chomp.to_i


if sideA == sideB && sideA == sideC
  puts 'У вас равносторонний треугольник.'

elsif sideA == sideB || sideA == sideC || sideB == sideC
  puts 'У Вас равнобедренный треугольник'

else
  if sideA > sideB && sideA > sideC
    hypotenuse = sideA
    hypotenuseName = 'сторона А'
    leg1 = sideB
    leg2 = sideC

  elsif sideB > sideA && sideB > sideC
    hypotenuse = sideB
    hypotenuseName = 'сторона B'
    leg1 = sideA
    leg2 = sideC

  else sideC > sideA && sideC > sideA
    hypotenuse = sideC
    hypotenuseName = 'сторона С'
    leg1 = sideA
    leg2 = sideB
  end

  puts "Гипотинуза: #{hypotenuseName} ее длина #{hypotenuse}"

  if hypotenuse == Math.sqrt(leg1**2 + leg2**2)
    puts 'У вас прямоугольный треугольник'
  else
    puts 'У вас не прямоугольный треугольник'
  end
end