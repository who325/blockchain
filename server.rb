#훌륭한 웹 프레임워크인 시나트라를 활용
#sinatra install --> command line 
#gem install sinatra --no-ri --no-rdoc
#컨트롤씨 누르고 다시 로드해야 변경사항이 반영됨


# encoding: UTF-8

require 'sinatra'
require './block_class'


aBlock = Blockchain.new

get'/number_of_blocks' do 
	aBlock.all_blocks.size.to_s
end

#작은녀석이 던진 블록을 받는 녀석. 리시버
get'/recv' do
	recv_block = JSON.parse(params["blocks"]) #포장된 제이슨파일을 파스해서 루비가 알아볼수있는 형태로 저장
	aBlock.recv(recv_block)
	aBlock.all_blocks.to_json #json 형태로 리턴 - 호출한녀석한테 리턴이 그대로 대치가 됨 
end

get'/ask' do
	aBlock.ask_other_block.to_s

end

#내 컴퓨터가 누구랑 이웃인지 저장을 하는 것
get'/add_node' do
	aBlock.add_node(params[:node]).to_s
	#aBlock.add_node(params["node"]) -> 이것도 같은거임
end


get'/' do #이게 주소임. 여기 들어가면 텍스트를 찍자 라는 것

	message = "<center>"

	aBlock.all_blocks.each do |b| #블록을 하나 뽑아서 돌아가는 것 (내 블록 b)
		message << "번호: " + b['index'].to_s + "<br>" #ruby는 문자열도 이런식으로 밀어넣을수있음
		message << "시간: " + b['time'].to_s + "<br>"
		message << "Nonce: " + b['nonce'].to_s + "<br>"
		message << "앞 주소: " + b['previous_address'].to_s + "<br>"
		message << "내 주소: " + Digest::SHA256.hexdigest(b.to_s) + "<br>"
		message << "Transactions: " + b["transactions"].to_s + "<br>"
		message << "<hr>" #한줄 그어주는 것
	end
	message + "</center>" #</> 문자열을 브라우즈에서 띄우는거기때문에 html로 해석이 되는거임
end

get'/mine' do
	aBlock.mining.to_s
	#to_s : to string, to_i : to integer
end


get'/trans' do
	aBlock.make_a_trans(params["sender"], params["recv"], params["amount"]).to_s
	
end


get'/new_wallet' do
	aBlock.make_a_new_wallet.to_s
end

get'/all_wallet' do
	aBlock.show_all_wallet.to_s
end



'''

http://localhost:4567/
이런식으로 블록에 거래정보가 계속 기록되고 
 송금자 입금자에게 거래트래픽이 왔다갔다 하는건 아님. 제3자에게 거래정보가 계속 저장되는게 이상하지 ㅋㅋ
지렁이 게임이랑 비슷하다!

etherscan.io도 시간이 나면 수업시간에...

블록을 해킹하면 주소값이 달라져서 새로운 블록으로 인식됨 -> 도태됨

루비에서 아무것도 없는 빈 리스트를 해싱하면 nil 값이 해싱됨.

컨펌은 결국 뒤에 블록이 붙는 것. 6컨펌은 블록이 붙었는데 뒤에 6개가 더 붙어야 아 안전하구나 하는 것

결국 거래소에서도 똑같은 방식으로 동작을 하는 것 - 주소를 만들어서 보내고 ... 
박제는 마이닝할때 일어남. 난스값을 찾았으면 블록을 만들때

UUID: universally unique id -> 범용고유식별자 
이걸 만들겠다 라고 하면 절대 겹칠수 없는 아이디라는 것. 만드는데 시간이 오래걸리면 안됨. 지갑만들때. 
절대 같을 수 없는것이 보장되는 것. 블록체인 소스보면 알수있음. 같은게 나올 수 없음.
UUID ruby -> secureRandom이라는 라이브러리 이용
'''
