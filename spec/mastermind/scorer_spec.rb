require File.join(File.dirname(__FILE__), "/../spec_helper")

module Mastermind
  
  # The Scorer handles the submit guess feature by returning 
  # the mark upon a guess
  describe Scorer do
    
    context "code contains no duplicates" do
    
      before(:all) do
        @scorer = Scorer.new(%w[r g y c])
      end
    
      context "no pegs are correct" do

        it "should return '' when nothing matches" do
          @scorer.guess(%w[w w w w])
          @scorer.mark.should == ""
        end
      
      end
    
      context "one color correct" do
      
        it "should return 'b' when in the correct position" do
          @scorer.guess(%w[r w w w])
          @scorer.mark.should == "b"
        end

        it "should return 'w' when /not/ in the correct position" do
          @scorer.guess(%w[w w r w])
          @scorer.mark.should == "w"
        end
      
      end
    
      context "two colors correct" do
      
        it "should return 'bb' when both are in the correct position" do
          @scorer.guess(%w[w g w c])
          @scorer.mark.should == "bb"
        end
      
        it "should return 'bw' when one is in the correct position and the other is not" do
          @scorer.guess(%w[w r w c])
          @scorer.mark.should == "bw"
        end
      
        it "should return 'ww' when both are /not/ in the correct position" do
          @scorer.guess(%w[g w c w])
          @scorer.mark.should == "ww"        
        end
      
      end
    
      context "three colors correct" do
      
        it "should return 'bbb' when all are in the correct position" do
          @scorer.guess(%w[w g y c])
          @scorer.mark.should == "bbb"
        end

        it "should return 'bbw' when two are in the correct position and one is not" do
          @scorer.guess(%w[w r y c])
          @scorer.mark.should == "bbw"
        end
      
        it "should return 'bww' when one is in the correct position and the others are not" do
          @scorer.guess(%w[w r g c])
          @scorer.mark.should == "bww"
        end
      
        it "should return 'www' when none are in the correct position" do
          @scorer.guess(%w[w r g y])
          @scorer.mark.should == "www"
        end

      end
    
      context "all colors correct" do
      
        it "should return 'bbbb' when all are in the correct position" do
          @scorer.guess(%w[r g y c])
          @scorer.mark.should == "bbbb"
        end
      
        it "should return 'bbww' when two are in the correct position and the others are not" do
          @scorer.guess(%w[r g c y])
          @scorer.mark.should == "bbww"
        end
      
        it "should return 'bwww' when one is in the correct position and the others are not" do
          @scorer.guess(%w[y r g c])
          @scorer.mark.should == "bwww"
        end
      
        it "should return 'wwww' when none are in the correct position" do
          @scorer.guess(%w[c r g y])
          @scorer.mark.should == "wwww"
        end
      end
      
      context "guess contains duplicates" do
        
        it "should return 'b' when one matches in the correct position" do
          @scorer.guess(%w[g g g g])
          @scorer.mark.should == "b"
        end
        
        it "should return 'bb' when two match in the correct position" do
          @scorer.guess(%w[g g y y])
          @scorer.mark.should == "bb"
        end
        
        it "should return 'bw' when one matches in the correct position and the other does not" do
          @scorer.guess(%w[y g g y])
          @scorer.mark.should == "bw"
        end
        
      end
      
    end
    
    context "code contains duplicates" do
      
      before(:all) do
        @duplicates_scorer = Scorer.new(%w[r y y r])
      end

      it "should return 'bb' when the guess is 'yccy'" do
        @duplicates_scorer.guess(%w[y c c y])
        @duplicates_scorer.mark.should == "ww"
      end
      
      it "should return 'bww' when the guess is 'yyry'" do
        @duplicates_scorer.guess(%w[y y r y])
        @duplicates_scorer.mark.should == "bww"
      end
      
    end
    
  end
end