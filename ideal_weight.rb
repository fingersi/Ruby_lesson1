puts 'Добрый день, введите, пожалуйста, свое имя.'
userName = gets.chomp

puts 'Введите наш рост.'
userHeight = gets.chomp.to_i

puts "#{userName}, ваш идеальный вес: #{(userHeight - 110) * 1.15}"