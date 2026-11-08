class MarkdownStatsJob
  def perform(file)
    puts "文字数: #{File.read(file).length}\nファイル名: #{File.basename(file, ".md")}"
  end
end




