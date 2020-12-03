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
  hypotenuse = [sideA, sideB, sideC].max

  puts hypotenuse

  if sideA == hypotenuse
    hypotenuse = sideA
    hypotenuseName = 'сторона А'
    legSum = sideB ** 2 + sideC ** 2

  elsif sideB == hypotenuse
    hypotenuseName = 'сторона B'
    legSum = sideA ** 2 + sideC ** 2

  else sideC == hypotenuse
    hypotenuseName = 'сторона С'
    legSum = sideA ** 2 + sideB ** 2
  end

  puts "Гипотинуза: #{hypotenuseName} ее длина #{hypotenuse}"

  if hypotenuse == Math.sqrt(legSum)
    puts 'У вас прямоугольный треугольник'

  else
    puts 'У вас не прямоугольный треугольник'
    
  end
end