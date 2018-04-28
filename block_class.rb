# encoding: UTF-8
#blockchain code를 넣기 시작하는 코드 

class Blockchain

	def initialize

	end

	def mining
		begin
			nonce = rand(100) #자신의 난스값 알고리즘이 들어가겠지
		end while nonce != 0
		nonce
		#"Found a block"
	end

	def transaction
		"Finalized"
	end

end

