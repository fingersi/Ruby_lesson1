puts 'Добро пожаловать в программу решения квадратных уровнений.'
puts 'Программа предложит Вам ввести коэфициенты квадратного уровнения.'
puts 'ВВедить коэфициенты нужно вводить по следующему принципу: a*X^2 + b*X + C = 0.'

puts 'Введите коэфициент A'
coefA = gets.chomp.to_i

puts 'Введите коэфициент B'
coefB = gets.chomp.to_i

puts 'Введите коэфициент C'
coefC = gets.chomp.to_i

descriminant = coefB ** 2 - 4 * coefA * coefC
puts "D = #{descriminant}"

if descriminant < 0
  puts 'У вашего квадратного уровнения нет корней. =('
else 
  x1 = (-coefB + Math.sqrt(descriminant))/ 2 * coefA 
  x2 = (-coefB - Math.sqrt(descriminant))/ 2 * coefA 
  puts "Для вашего квадратного уровная найдены следующие корни:"
  puts "x1 = #{x1}"
  puts "x2 = #{x2}"
end

