require_relative 'bunny.rb'
# Create players as a hash
@players = { P1: 3, P2: 3}

# Game method
def game(current_player)
	rand_1 = rand(0..20)
	rand_2 = rand(0..20)
	puts "What is #{rand_1} + #{rand_2}?"
	answer = gets.chomp.to_i
	puts "..."
	sleep(1)
	if rand_1 + rand_2 == answer
		puts "\n\n\nGreat job!"
		puts "\n=========================\n"
	elsif @turn == 1
		puts "\n\n\nSorry that's incorrect"
		@players[:P1] -= 1
		puts "Player 1 life :#{@players[:P1]}"
		puts "\n=========================\n"
	elsif @turn == -1
		puts "\n\n\nSorry that's incorrect"
		@players[:P2] -= 1
		puts "Player 2 life :#{@players[:P2]}"
		puts "\n=========================\n"
	end
	@turn = @turn * -1
end

# while game loop
def looping_gameplay
	@turn = 1
	bunny
	while @players[:P1] > 0 && @players[:P2] > 0
		if @turn == 1
			puts "Ready Player 1?"
		else
			puts "Ready Player 2?"
		end
		game(@turn)
	end
	if @players[:P1] == 0
		puts "Sorry Player 1... you ran out of lives."
		puts "Game over"
	elsif @players[:P2] == 0
		puts "Sorry Player 2... you ran out of lives."
		puts "Game over"
	end
end

looping_gameplay
# 