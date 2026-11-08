class MiniQueue
  def initialize
    @jobs = []
  end

  def add_job(job_class, file)
    @jobs.push({ job_class: job_class, file: file })
  end

  def shift_jobs
    if @jobs.empty? == false
      job = @jobs.shift
    else 
      puts "データがありません"
    end
  end
end



