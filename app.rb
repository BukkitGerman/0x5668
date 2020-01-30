require 'sinatra/base'
require 'pry'
require 'net/http'
require 'rdiscount'

class Blog < Sinatra::Base 
	set :port, 3000
	set :root, File.dirname(__FILE__)
	set :views, Proc.new { File.join(root, "views") }

	
	
	# => Routes
	get '/' do
		@files = Dir.entries("./content")
					.reject{|x| x.chars.first == '.'}
					.reject{|x| x == 'index.erb'}

		@titles = ["Blank_Blog"]
		
		erb :index
	end

	get '/:page' do 

		@files = Dir.entries("./content")
					.reject{|x| x.chars.first == '.'}
					.reject{|x| x == 'index.erb'}
		
		@content = RDiscount.new(File.open("content/" + params["page"].gsub("-", "_").concat(".md"), "r").read).to_html
		erb :template
	end

	run! if app_file == $0
end