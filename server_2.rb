#sinatra code
require 'sinatra' 
require './block'

aBlock = Blockchain.new

get '/' do 

	"This is Block List."

end

get '/mine' do
	aBlock.mining.to_s
end


''' http://localhost:4567/

'''