require 'net/http'
require 'uri'

class HttpStatusJob
  def perform(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    res = http.request(Net::HTTP::Get.new(uri))
    puts uri
    puts "ステータス: #{res.code}"
  end
end


