require_relative "../examples/markdown_stats_job"
require_relative "../examples/http_status_job"
require_relative "mini_queue"


queue = MiniQueue.new
queue.add_job(MarkdownStatsJob, "README.md")
queue.add_job(MarkdownStatsJob, "devlog/2026-11-05.md")
queue.add_job(MarkdownStatsJob, "devlog/2026-11-08.md")
queue.add_job(HttpStatusJob, "https://chatgpt.com")
queue.add_job(HttpStatusJob, "https://aiueo.com")
queue.add_job(HttpStatusJob, "https://example.com")
queue.add_job(HttpStatusJob, "https://github.com")



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


