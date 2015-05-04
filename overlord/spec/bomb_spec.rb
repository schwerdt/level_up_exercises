require './bomb.rb'

VALID_ACT_CODE = 2468
VALID_DEACT_CODE = 1357
INVALID_ACT_CODE = "abcd"
INVALID_DEACT_CODE = "hello"
TIME_REMAINING = 30

describe Bomb do
  let(:newbomb_valid) {Bomb.new(VALID_ACT_CODE, VALID_DEACT_CODE) }
#  let(:newbomb_invalid) {Bomb.new(INVALID_ACT_CODE, INVALID_DEACT_CODE) }
  
  describe("bomb object contains all data needed to operate the bomb") do
    it "has #{TIME_REMAINING} seconds after the bomb is created but before activation." do
      expect(newbomb_valid.time_remaining).to eql(TIME_REMAINING)
    end

    it "is in an inactive state before start_bomb is called" do 
      expect(newbomb_valid.active).to eql(false)
    end

    it "is not exploded before bomb_bstart is called" do
      expect(newbomb_valid.exploded).to eql(false)
    end
 
    it "can become active by calling the start_bomb function" do 
      newbomb_valid.start_bomb(VALID_ACT_CODE)
      expect(newbomb_valid.active).to eql(true)
    end

    it "can be deactivated using the deactivation code" do 
      newbomb_valid.attempt_deactivation(VALID_DEACT_CODE)
      expect(newbomb_valid.active).to eql(false)
    end

    it "can be restarted after successful deactivation" do 
      newbomb_valid.restart_bomb(VALID_ACT_CODE)
      expect(newbomb_valid.active).to eql(true)
    end

    it "explodes after #{TIME_REMAINING} seconds" do
      newbomb_valid.restart_bomb(VALID_ACT_CODE)
      sleep(TIME_REMAINING+2)
      expect(newbomb_valid.exploded).to eql(true)
    end
  end
end
    
