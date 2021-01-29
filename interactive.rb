require_relative 'models/index'
i = Index.new

loop do
  is = gets.chomp
  if is == 'exit'
    break
  elsif is[0..1] == '?='
    i.search is[2..]
    puts "\n"
  else
    i.parse_and_index is
  end
end
