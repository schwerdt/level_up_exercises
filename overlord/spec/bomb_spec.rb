require './bomb.rb'

VALID_ACT_CODE = 2468
VALID_DEACT_CODE = 1357
INVALID_ACT_CODE = "abcd"
INVALID_DEACT_CODE = "hello"
TIME_REMAINING = 30

describe Bomb do
  let(:newbomb_valid) {Bomb.new(VALID_ACT_CODE, VALID_DEACT_CODE) }
  let(:newbomb_invalid) {Bomb.new(INVALID_ACT_CODE, INVALID_DEACT_CODE) }
  
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
    newbomb_valid.start_bomb(VALID_ACT_CODE)
    newbomb_valid.attempt_deactivation(VALID_DEACT_CODE)
    expect(newbomb_valid.active).to eql(false)
  end

  it "can be restarted after successful deactivation" do 
    newbomb_valid.start_bomb(VALID_ACT_CODE)
    newbomb_valid.attempt_deactivation(VALID_DEACT_CODE)
    newbomb_valid.restart_bomb(VALID_ACT_CODE)
    expect(newbomb_valid.exploded).to eql(false)
    expect(newbomb_valid.active).to eql(true)
  end

  it "explodes after #{TIME_REMAINING} seconds" do
    newbomb_valid.start_bomb(VALID_ACT_CODE)
    sleep(40)  #Why do I wait 40 s?
    expect(newbomb_valid.exploded).to eql(true)
  end

  it "complains when the activation code is not four digits" do
    expect{Bomb.new(INVALID_ACT_CODE,VALID_DEACT_CODE)}.to raise_error(BombCodeError)
  end
end