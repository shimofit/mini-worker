require_relative "../examples/markdown_stats_job"
require_relative "../examples/http_status_job"
require_relative "../examples/fractal_shape_job"
require_relative "mini_queue"

settings = {
  width: 600,
  height: 401,
  max_iterations: 100
}

queue = MiniQueue.new
queue.add_job(MandelbrotJob, settings)



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


