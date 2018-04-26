# encoding: UTF-8

#commit - push 계속 해서 서버에 업데이트하는게 중요함.
#현실에 존재하는 개념을 코드로 구현해보자 -> class

class Dog
	#태어날 때 가지고 있는 값들을 선언함
	def initialize
		@weight = 0.5
		#  '@'를 넣으면 클래스가 살아있는 동안 꾸준히 유지되는 값으로 정의됨
	end

	def eat
		@weight = @weight + 0.5
		puts @weight
	end

	def run
		
	end
end

#class 새로 탄생하는데 그렇게 낳아진 개는 dog에 저장을 한다
dog = Dog.new
dog2 = Dog.new

dog.eat
dog.eat
dog.eat

dog2.eat

