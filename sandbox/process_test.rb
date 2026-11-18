require "rbconfig"

command = [RbConfig.ruby, "lib/mini_worker.rb"]

child_a = IO.popen(command, "r")
child_b = IO.popen(command, "r")

puts child_a.read
puts child_b.read

child_a.close
child_b.close