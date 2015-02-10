# game start: name players, select difficulty
# gameplay loop: checkscores?, launch questions
# game questions: ask questions, answer question, incr score, lose life
# end check life

#player #/Name

require_relative 'Players_Class'

def set_difficulty
	puts "Please enter difficulty:"
	puts "Easy: Adding numbers from 0-20"
	puts "Medium: Adding or subtracting numbers from 0-20"
	puts "Hard: Adding, subtracting, or multiplying numbers from 0-20"
	@difficulty = gets.chomp.downcase
	case @difficulty
	when "easy"
		puts "Have fun!"
	when "medium"
		puts "A little tougher, but have fun!"
	when "hard"
		puts "...good luck."
	else
		abort
	end
end

def ask_question
	rand1 = rand(0..20)
	rand2 = rand(0..20)
	player = player_num
	operator = set_operator
	puts "#{player.name} what is #{rand1} #{operator} #{rand2}?"
	player_answer = gets.chomp.to_i
	comp_answer = generate_answer(rand1, operator, rand2)
	resolve_turn(player_answer, comp_answer)
end

def generate_answer(rand_num1, operator, rand_num2)
	case operator
	when "+"
		rand_num1 + rand_num2
	when "-"
		rand_num1 - rand_num1
	when "*"
		rand_num1 * rand_num2
	end
end


def set_operator
	rand_op = 0
	case @difficulty
	when "medium"
		rand_op = rand(0..1)
	when "hard"
		rand_op = rand(0..2)
	end
	operator_interpreter(rand_op)
end


def operator_interpreter(random_operator)
	if random_operator == 0
		"+"
	elsif random_operator == 1
		"-"
	else
		"*"
	end
end

def resolve_turn(player_answer, comp_answer)
	player = player_num
	if player_answer == comp_answer
		puts "Correct!"
		puts "#{player.name} gets a point!"
		player_num.score_up
	elsif player_answer != comp_answer
		begin
		raise IncorrectGuessError.new, "That was a dumb move..."
		rescue IncorrectGuessError
			puts "I mean..."
		end
		puts "That wasn't right..."
		puts "#{player.name} loses a health point."
		player_num.life_drop
	end
end

def game_over?
	if player_num.life == 0
		begin
			puts "Game Over"
		raise YouDeadError.new, "So you died... and that's not great."
		rescue YouDeadError
			puts "But you tried really hard!"
			true
		end
	else
		false
	end
end

def checkscores
	puts "Would you like to check scores? (Y/N)"
	input = gets.chomp.downcase
	if input == "y" || input == "yes"
		puts "#{@player1.name} has #{@player1.score} points and #{@player1.life} life"
		puts "#{@player2.name} has #{@player2.score} points and #{@player2.life} life"
	end
end

def player_num
	if @turn == 1
		@player1
	else
		@player2
	end
end

def player_name
	if @turn == 1
		@player1.name
	else
		@player2.name
	end
end

def game_loop
	@turn = -1
	while game_over? == false
		@turn = @turn * -1
		checkscores
		ask_question
	end
end

def gamestart
	@player1 = Player.new("Player 1", 3, 0)
	@player2 = Player.new("Player 2", 3, 0)

	@player1.name_players(1)
	@player2.name_players(2)

	set_difficulty

	game_loop
end
