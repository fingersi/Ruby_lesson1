puts 'Добро пожаловать в программу решения квадратных уровнений.'
puts 'Программа предложит Вам ввести коэфициенты квадратного уровнения.'
puts 'ВВедить коэфициенты нужно вводить по следующему принципу: a*X^2 + b*X + C = 0.'

puts 'Введите коэфициент A'
coef_a = gets.chomp.to_f

puts 'Введите коэфициент B'
coef_b = gets.chomp.to_f

puts 'Введите коэфициент C'
coef_c = gets.chomp.to_f

descriminant = coef_b ** 2 - 4 * coef_a * coef_c
puts "D = #{descriminant}"

if descriminant < 0
  puts 'У вашего квадратного уровнения нет корней. =('
elsif descriminant > 0
  sqrt_descr = Math.sqrt(descriminant)
  x1 = (- coef_b + sqrt_descr) / 2 * coef_a 
  x2 = (- coef_b - sqrt_descr) / 2 * coef_a 
  puts "Дискрименант равен: #{descriminant}. Для вашего квадратного уровная найдены следующие корни:"
  puts "x1 = #{x1}"
  puts "x2 = #{x2}"
else
  x1 = - coef_b / 2 * coef_a 
  puts "Дискрименант равен: #{descriminant}. Для вашего квадратного уровная найден следующий корень:"
  puts "x1 = #{x1}"
end

