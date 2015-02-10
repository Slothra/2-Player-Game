class Player
	attr_accessor :name, :life, :score
	
	def initialize(name, life, score)
		@name = name
		@life = 3
		@score = 0
	end

	def name_players(num)
		puts "Enter Player #{num}'s name:\n\n"
		input = gets.chomp.blue
		puts "Welcome #{input}!"
		@name = input
	end

	def life_drop
		@life = @life - 1
	end

	def score_up
		@score = @score + 1
	end
end