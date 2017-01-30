#!/usr/bin/env ruby
Dir.chdir("src")do
  ret=system('flex calc.l')
  puts "flex #{ret}"
  ret=system('bison -d calc.y')
  puts "bison #{ret}"
end
ret=system('gcc -o lang src/calc.tab.c src/lex.yy.c -lm')
puts "gcc #{ret}"

