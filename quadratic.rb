puts 'Добро пожаловать в программу решения квадратных уровнений.'
puts 'Программа предложит Вам ввести коэфициенты квадратного уровнения.'
puts 'ВВедить коэфициенты нужно вводить по следующему принципу: a*X^2 + b*X + C = 0.'

puts 'Введите коэфициент A'
coefA = gets.chomp.to_f

puts 'Введите коэфициент B'
coefB = gets.chomp.to_f

puts 'Введите коэфициент C'
coefC = gets.chomp.to_f

descriminant = coefB ** 2 - 4 * coefA * coefC
puts "D = #{descriminant}"

if descriminant < 0
  puts 'У вашего квадратного уровнения нет корней. =('
elsif descriminant > 0
  sqrtDescr = Math.sqrt(descriminant)
  x1 = (-coefB + sqrtDescr) / 2 * coefA 
  x2 = (-coefB - sqrtDescr) / 2 * coefA 
  puts "Дискрименант равен: #{descriminant}. Для вашего квадратного уровная найдены следующие корни:"
  puts "x1 = #{x1}"
  puts "x2 = #{x2}"
else
  x1 = -coefB / 2 * coefA 
  puts "Дискрименант равен: #{descriminant}. Для вашего квадратного уровная найден следующий корень:"
  puts "x1 = #{x1}"
end

