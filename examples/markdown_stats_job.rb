class MarkdownStatsJob
  def perform(file)
    puts "文字数: #{File.read(file).length}\nファイル名: #{File.basename(file, ".md")}"
  end
end

MarkdownStatsJob.new.perform("devlog/2026-11-05.md")
