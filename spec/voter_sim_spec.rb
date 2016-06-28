require './voter_sim.rb'
describe Politician do
  it "Create politicians who have a name and party affiliation" do
    marco = Politician.new("Marco Rubio", "Republican")
    expect(marco).to be_a(Politician)
  end
end
describe Voter do
  it "creates a voter with a name and party affiliation" do
    zach = Voter.new("Zach Roberts", "Republican")
  end
end
