puts "Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1)."

hash_with_vowel = {}
index = 1
('a'..'z').to_a.each do |letter| 
  hash_with_vowel[letter] = index if letter.scan(/[aeoui]/).any?
  index += 1
end

hash_with_vowel.each{|letter, number| puts "Гласная: #{letter}. Её порядковый номер в алфавите: #{number}" }

