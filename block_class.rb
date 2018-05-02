# encoding: UTF-8
#blockchain code를 넣기 시작하는 코드 

require 'securerandom'

class Blockchain

	def initialize
		@chain = []
		@trans = []
		@wallet = {} 
	end

	def show_all_wallet
		@wallet 
	end


	def make_a_new_wallet
		address = SecureRandom.uuid.gsub('-','')
		@wallet[address] = 1000 #test를 위해서 1000코인이 있다고 하자
		@wallet
	end

	#센더랑 리시버가 실제 유효한지 체크: 더블스팬딩 막기위해
	#지갑이 있는 경우에만 전송을 하겠다
	def make_a_trans(s,r,a)
		
		if @wallet[s].nil?
			"보내는 주소가 잘못되었음."
		elsif @wallet[r].nil?
			"받는 주소가 잘못되었음."
		elsif @wallet[s].to_f < a.to_f
			"No money..."
		else
			#실제 블록체인과 다름. 원래 컨퍼메이션 할 때 반영이 되는부분임
			#마이닝을 통해서 거래가 박제가 되었을때 거래를 인정을 하지 실제는.
			#되게 느리지만 decentralized를 유지하기 위해서 이렇게 함 
			#아래 부분은 시중은행이 하는 방식이지. 중앙화된.
			@wallet[s] = @wallet[s].to_f - a.to_f
			@wallet[r] = @wallet[r].to_f + a.to_f

			trans = {
				"sender" => s,
				"receiver" => r,
				"amount" => a
			}
			@trans << trans #주의. 골뱅이 트랜스와 그냥 트랜스는 완전 다른것임
			@trans
		end
	end



	def mining
		history = []
		current_time = Time.now.to_f
		begin
			nonce = rand(10000000) #자신의 난스값 알고리즘이 들어가겠지
			#nonce값을 기반으로 해싱해보자 - (예시) 해쉬값이 '0000'인 입력값을 찾으시오
			#보통 어떠한 수식을 만족하는 값으라고 하지

			#검증은 되게 쉬운데 거꾸로 찾기는 어려운 이런 문제를 보통 내지
			history << nonce #히스토리에 난스값을 밀어넣음
			hashed = Digest::SHA256.hexdigest(nonce.to_s)

		end while hashed[0..3] != '0000'

		

		nonce #루비는 맨 마지막라인의 이 값만 호출해서 찍힘... 그래서 위에 puts해도 안찍혀
		#그래서 리턴값을 여러개로 하고싶으면 아래와 같이 하자
		return_array = []

		return_array << Time.now.to_f - current_time
		return_array << nonce
		return_array

		block = {
			"index" => @chain.size + 1, #몇번째 블록
			"time" => Time.now.to_i, #현재 타임
			"nonce" => nonce, #위 난스값을 가진 블록
			"previous_address" => Digest::SHA256.hexdigest(last_block.to_s),
			"transactions" => @trans #블록에 거래정보 박제됨
		}
		@trans = [] #리셋해야지
		@chain << block 
		block 

	end

	def last_block
		@chain[-1] #마지막 블럭을 얻어올 수 있음
	end

	def all_blocks
		@chain #전체 리스트만 찍어주는 함수
	end

end

#코빗api 활용 - GET https://api.korbit.co.kr/v1/ticker --> 만들어서 본전찾으면 메일보내는 코드 아마존 서버에 돌려놓으면 됨..
#DAEMON 을 활용하면 컴터 꺼도 계속 코드 돌아감
#그래픽카드를 활용했더니 병렬적으로 여러개 동시에 돌릴 수 있음 - 어쩌다 그래픽카드 해봤더니 좋아서 그후로 날개돋힌듯...

