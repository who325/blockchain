#훌륭한 웹 프레임워크인 시나트라를 활용
#sinatra install --> command line 
#gem install sinatra --no-ri --no-rdoc
#컨트롤씨 누르고 다시 로드해야 변경사항이 반영됨


# encoding: UTF-8

require 'sinatra'
require './block'

get'/' do #이게 주소임. 여기 들어가면 텍스트를 찍자 라는 것
	"This is Block List."
end

get'/mine' do
	aBlock.mining.to_s
end



aBlock = Blockchain.new




#http://localhost:4567/

