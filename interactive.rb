require_relative 'models/index'
i = Index.new

loop do
  is = gets.chomp
  if is == 'exit'
    break
  elsif is == 'search'
    puts "\n\nEnter search term:"
    i.search gets.chomp
    puts "\n"
  else
    i.parse_and_index is
  end
end
