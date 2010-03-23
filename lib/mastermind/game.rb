module Mastermind
  class Game
    
    def initialize(messenger)
      @messenger = messenger
    end
    
    def start(secret_code = nil)
      @messenger.puts "Welcome to Mastermind!"
      @messenger.puts "Enter guess:"
      @scorer = Scorer.new(secret_code)
      @guess_counter = 0
    end
    
    def guess(guess)
      @guess_counter += 1
      @scorer.guess(guess)
      @messenger.puts(@scorer.mark)
      @messenger.puts(game_over_message) if over?
    end
    
    def over?
      return @scorer.mark == "bbbb"
    end
    
    def game_over_message
      msg = ""
      if @guess_counter < 3
        msg << "Congratulations! "
      end
      msg << "You broke the code in #{@guess_counter} guess#{(@guess_counter == 1) ? '.' : 'es.'}" 
      return msg
    end
  end
end