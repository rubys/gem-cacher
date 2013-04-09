require 'rubygems'
require 'sinatra'
require 'net/http'
require 'net/https'
require 'cgi'

get '/' do
  "rubygems.org caching service"
end

get '/api/v1/dependencies' do
  puts "Looking up dependencies for #{params[:gems]}"
  https_get "https://bundler.rubygems.org/api/v1/dependencies", 
    :gems => params[:gems]
end

get '/gems/:gem' do
  get_gem params[:gem] unless File.exist? "gems/#{params[:gem]}"
  send_file "gems/#{params[:gem]}"
end

def https_get(uri, args = {})
  uri = URI(uri) unless URI === uri
  args = args.delete_if {|name, value| value.nil?}
  unless args.empty?
    uri.query = args.map {|name, value| "#{name}=#{CGI.escape value}"}.join('&')
  end
  http = Net::HTTP.new(uri.host, uri.port)
  if uri.scheme == 'https'
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  raise "#{response.code} response" unless response.code == '200'
  response.body
end

def get_gem(gem_name)
  puts "#{gem_name} does not exist locally, lets download it"
  puts `wget -P gems https://www.rubygems.org/gems/#{gem_name}`
end
