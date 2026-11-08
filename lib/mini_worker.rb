require_relative "../examples/markdown_stats_job"
require_relative "mini_queue"

jobs = MiniQueue.new
jobs.add_job(MarkdownStatsJob, "README.md")
job = jobs.shift_jobs
job[:job_class].new.perform(job[:file])

