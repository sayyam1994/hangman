class Dictionary
    def initialize
        @file = File.readlines "dictionary.txt"
    end

    def secret_word_generator
        loop do 
            secret_word = @file[rand(@file.length)].gsub("\n", "")
            return secret_word.downcase if (secret_word.length > 4 && secret_word.length < 13)
        end
    end
end

class Game
    def initialize
        @secret_word = Dictionary.new
        @turns = 9
        @hidden_word_array = Array.new
        instructions
        hidden_word_generator
        get_player_guess
    end

    def instructions
        puts "***************************************"
        puts "**** Welcome To The Hangman Game! *****"
        puts "***************************************"
        puts "======================================="
        puts "************ Instructions *************"
        puts "***************************************"
        puts "1. The objective of the game is to guess"
        puts "letters to a secret word. The secret word"
        puts "is represented by a series of horizontal"
        puts "lines indicating its length. "
        puts "For example:"
        puts "If the secret word it 'chess', then it will "
        puts "be displayed as:"
        puts "_ _ _ _ _ \n "
        puts "2. You are given 9 chances. For each incorrect"
        puts "guess, the chances will decrease by 1. For each correct"
        puts "guess, the part of the secret word are revealed"
        puts "For example: If your guess is 's' then the result"
        puts "of the guess will be:"
        puts "_ _ _ s s \n "
        puts "3. When you guessed all the correct letters to the secret word"
        puts "or when you are out of chances, it will be game over."
        puts "4. Any time during the game, if you would like to save"
        puts "your progress, type 'save--' without the quotes"
        puts ""
        puts ""
    end

    def hidden_word_generator
        @hidden_word = @secret_word.secret_word_generator
        print "Secret Word: "
        for i in 0..@hidden_word.length-1 do
            @hidden_word_array[i] = "_ "    
        end
        print @hidden_word
        puts ""
        print @hidden_word_array.join
        puts ""
    end

    def get_player_guess
        loop do
            print "Please enter your guess:  "
            player_guess = gets.chomp.downcase
            if player_guess.length != 1
                puts "Please enter single letter only"
            else
                if (player_guess =~ /[a-z]/)
                    return player_guess
                    break
                else
                    puts "Please enter alphabets only"
                end
            end
        end
        check_player_input
    end

    def check_player_input
        player_guess = get_player_guess
        puts player_guess
        i = 0
        @hidden_word.split("").each do |x|
            if player_guess == x
                @hidden_word_array[i] = x 
            end
            i += 1
        end
        print @hidden_word_array.join
        check_winner
    end

    def turn_decreaser
        @turns -= 1
    end

    def check_winner
        if @hidden_word_array.join == @hidden_word
            puts "You have won the game"
        else
            turn_decreaser
            if @turns == 0
            puts "Sorry, you lost the game"
            else
                get_player_guess
            end
        end
    end
end

Game.new