require File.join(File.dirname(__FILE__), "/../spec_helper")

module Mastermind
  describe Game do
    
    before(:all) do
      @messenger = mock("messenger").as_null_object
      @game = Game.new(@messenger)
    end
    
    context "starting up" do
      it "should send a welcome message" do
        @messenger.should_receive(:puts).with("Welcome to Mastermind!")
        @game.start(%w[a b c d])
      end

      it "should prompt for the first guess" do
        @messenger.should_receive(:puts).with("Enter guess:")
        @game.start(%w[a b c d])
      end
    end
    
    context "breaking the code" do

      before(:each) do
        @game.start(%w[r g y b])
      end
      
      context "on the first guess" do
        
        it "should be over" do
          @game.guess(%w[r g y b])
          @game.should be_over
        end
        
        it "should return the message 'Congratulations! You broke the code in 1 guess.'" do
          @messenger.should_receive(:puts).with("Congratulations! You broke the code in 1 guess.")
          @game.guess(%w[r g y b])
        end
      end
      
      context "on the second guess" do
                
        it "should be over" do
          @game.guess(%w[r g y c])
          @game.guess(%w[r g y b])
          @game.should be_over
        end
        
        it "should return the message 'Congratulations! You broke the code in 2 guesses.'" do
          @messenger.should_receive(:puts).with("Congratulations! You broke the code in 2 guesses.")
          @game.guess(%w[r g y c])
          @game.guess(%w[r g y b])
        end
      end
      
      context "on three or more guesses" do
        it "should return the message 'You broke the code in 3 guesses.'" do
          @messenger.should_receive(:puts).with("You broke the code in 3 guesses.")
          2.times { @game.guess(%w[r g y c]) }
          @game.guess(%w[r g y b])
        end
        
        it "should return the message 'You broke the code in 4 guesses.'" do
          @messenger.should_receive(:puts).with("You broke the code in 4 guesses.")
          3.times { @game.guess(%w[r g y c]) }
          @game.guess(%w[r g y b])
        end
        
      end
      
      
    end
    
  end
end
