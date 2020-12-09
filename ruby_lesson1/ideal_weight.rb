puts 'Добрый день, введите, пожалуйста, свое имя.'
user_name = gets.chomp

puts 'Введите наш рост.'
user_height = gets.chomp.to_i

puts "#{user_name}, ваш идеальный вес: #{(user_height - 110) * 1.15)} 