class Politician

  attr_accessor :name, :party_affilitation, :new_person
  def initialize(name, party_affilitation) #Democrat or Republican
    @name = name
    @party_affilitation = party_affilitation
  end
end

class Voter
  attr_accessor  :name, :party_affilitation
  def initialize(name, party_affilitation) #Liberal, Conservative, Tea Party, Socialist, or Neutral
    @name = name
    @party_affilitation = party_affilitation
  end
end

class Voter_Sim
  attr_accessor :political_update, :hash_of_politicans, :name_response, :hash_of_voters, :person_to_be_updated
  def initialize
    @hash_of_politicans = {}
    @hash_of_voters = {}
  end

  def create_convo
    puts "What would you like to create?"
    puts "(P)olitician or (V)oter"
    create_convo_response = gets.chomp.downcase
    if create_convo_response == "p"
      create_politican
    else
      create_voter
    end
  end

  def main_menu
    puts "Main Menu"
    puts "*" * 10
    puts "What would you like to do?"
    puts "(C)reate, (L)ist, (U)pdate, or (D)elete"
    main_menu_answer = gets.chomp.downcase
    if main_menu_answer == "c"
      create_convo
    elsif main_menu_answer == "l"
      list
      main_menu
    elsif main_menu_answer == "u"
      update
    elsif main_menu_answer == "d"
      delete_voter(@delete)
    end
  end

  def create_politican
    puts "Create Politician"
    puts "Name?"
    name_of_politician = gets.chomp.downcase#.split.map(&:capitalize).join(' ')
    puts "Party?"
    political_party_of_politician = gets.chomp.downcase.capitalize!
    Politician.new(name_of_politician, political_party_of_politician)
    puts "Thanks, #{name_of_politician} is now in the system"
    @hash_of_politicans.store(name_of_politician, political_party_of_politician)
    main_menu
  end

  def create_voter
    puts "Create Voter"
    puts "Name?"
    name_of_voter = gets.chomp.downcase#.split.map(&:capitalize).join(' ')
    puts "Party?"
    voter_political_party = gets.chomp.downcase.capitalize!
    Voter.new(name_of_voter, voter_political_party)
    puts "Thanks, #{name_of_voter} is now in the system"
    @hash_of_voters.store(name_of_voter, voter_political_party)
    main_menu
  end

  def list
    puts "Politicians: #{@hash_of_politicans}"
    puts "Voters: #{@hash_of_voters}"
  end

  def update
    prompt_to_update
    if @hash_of_voters.flatten.include?(@person_to_be_updated) || @hash_of_politicans.flatten.include?(@person_to_be_updated)
      new_name_question
      if @name_response.include?("y")
        return new_name_voter if @hash_of_voters.flatten.include?(@person_to_be_updated)
        return new_name_politician if @hash_of_politicans.flatten.include?(@person_to_be_updated)
        main_menu
      elsif @name_response.include?("n")
        promote_to_update_politics
        if @political_update == "y" && @hash_of_voters.flatten.include?(@person_to_be_updated)
          new_politics_voter
        elsif @political_update == "y" && @hash_of_politicans.flatten.include?(@person_to_be_updated)
          new_politics_politician
        else
          main_menu
        end
      end
    else
      puts "We don't have that person if our system, please try again"
      prompt_to_update
    end
  end

  def promote_to_update_politics
    puts "Would you like to update #{@person_to_be_updated} politics?"
    politics_update = gets.chomp.downcase
    @political_update = politics_update
  end

  def prompt_to_update
    puts "Who would you like to update?"
    @person_to_be_updated = gets.chomp.downcase
  end

  def new_name_question
    puts "New name for #{@person_to_be_updated}, (Y)es or (N)o?"
    @name_response = gets.chomp.downcase
  end

  def new_name_voter
    puts "Enter new name"
    new_name_response = gets.chomp.downcase
    @hash_of_voters[new_name_response] = @hash_of_voters.delete(@person_to_be_updated)
    main_menu
  end

  def new_name_politician
    puts "Enter new name"
    new_name_response = gets.chomp.downcase
    @hash_of_politicans[new_name_response] = @hash_of_politicans.delete(@person_to_be_updated)
    main_menu
  end

  def new_politics_politician
    puts "Enter #{@person_to_be_updated} new Political Party"
    new_political_party = gets.chomp.downcase
    @hash_of_politicans[@person_to_be_updated] = new_political_party
    main_menu
  end
  def new_politics_voter
    puts "Enter #{@person_to_be_updated} new Political Party"
    new_political_party = gets.chomp.downcase
    @hash_of_voters[@person_to_be_updated] = new_political_party
    main_menu
  end

  def delete_voter(voter)
    delete_voter_dialog
    if @hash_of_voters.include?(@delete)
      @hash_of_voters.delete(@delete)
    elsif @hash_of_politicans.include?(@delete)
      @hash_of_politicans.delete(@delete)
    end
    main_menu
  end
  
  def delete_voter_dialog
    list
    puts "who would you like to delete?"
    delete = gets.chomp
    @delete = delete
  end
end
