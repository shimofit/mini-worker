class MiniQueue
  def initialize
    @jobs = []
  end

  def add_job(job_class, data)
    @jobs.push({ job_class: job_class, data: data })
  end

  def shift_job
    if @jobs.empty? == false
      job = @jobs.shift
    end
  end
end



