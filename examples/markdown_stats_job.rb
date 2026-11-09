class MarkdownStatsJob
  def perform(file)
    puts "ファイル名: #{File.basename(file, ".md")}\n文字数: #{File.read(file).length}"
  end
end




