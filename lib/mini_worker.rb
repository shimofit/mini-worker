require_relative "../examples/fractal_shape_job"
require_relative "mini_queue"
require "json"

job_type = STDIN.gets.chomp
job_class = Object.const_get(job_type)
text = STDIN.gets
settings = JSON.parse(text, symbolize_names: true)

queue = MiniQueue.new
queue.add_job(job_class, settings)



while true
  job = queue.shift_job

  if job == nil
    break
  end

  begin
    job[:job_class].new.perform(job[:data])
  rescue => error
    puts "#{job[:job_class]}, #{job[:data]}でエラー\nエラーの種類: #{error.class}\n詳細: #{error.message}"
  end
end


