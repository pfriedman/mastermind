module Mastermind
  class Scorer
    
    MATCH_MARKER   = '-'
    EXACT_MATCH    = 'b'
    NONEXACT_MATCH = 'w'
    
    def initialize(code)
      @code = code
    end
    
    def guess(guess)
      @guess = guess
    end
    
    def mark
      return (EXACT_MATCH * number_of_exact_matches) + 
             (NONEXACT_MATCH * number_of_nonexact_matches)
    end
    
    private
    
      def number_of_exact_matches
        exact_matches = [@code, @guess].transpose.select { |a, b| a == b }
        return exact_matches.size
      end
      
      def number_of_nonexact_matches
        code = @code.clone
        @guess.each_with_index do |guess, idx|
          if code.include?(guess)
            code[code.index(guess)] = MATCH_MARKER
          end
        end
        matches = code.select{ |x| x == MATCH_MARKER }
        return matches.size - number_of_exact_matches
      end
    
  end
end
