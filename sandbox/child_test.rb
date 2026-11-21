require "json"

text = STDIN.gets
settings = JSON.parse(text, symbolize_names: true)

puts settings[:width]