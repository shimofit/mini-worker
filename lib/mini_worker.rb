jobs = [
  { name: "send_email", user: "田中" },
  { name: "resize_image", user: "佐藤" },
  { name: "create_report", user: "鈴木" }
]

until jobs.empty?
  job = jobs.shift
  puts "実行中: #{job[:name]} (user: #{job[:user]})"
end

p jobs

