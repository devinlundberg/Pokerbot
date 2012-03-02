# Helper methods defined here can be accessed in any controller or view in the application

require 'ruby-poker'

SamplePokerBot.helpers do
  # def simple_helper_method
  #  ...
  # end
  
  def formatCards(hand)
    fhand=[]
    hand.each do|card|
      val=card[:value].to_i
      suit=card[:suit]
      if val>9
        valhash=[10=>'T',11=>'J',12=>'Q',13=>'K',14=>'A']
        val=valhash[val]
      end
      fcard=val.to_s+suit
      fhand << fcard
    end
    return fhand
   end
  
  def bet(hand,community,chips, minbet)
    hand=formatCards(hand)
    hand=formatCards(community)
    hand1 = PokerHand.new(community+hand)
    com = PokerHand.new(community)
    if hand1>com
      amount=minbet
      raise_amount = rand(20) < 2 ? (0.1*chips).ceil : 0
      #randomly raise or bet
      if amount + raise_amount < 
        amount += raise_amount
      end
      return { :action => "bet", :amount => amount }
    else
      if minbet > 0.5*chips
        return { :action => "fold"}
      else
        return { :action => "bet", :amount => minbet }
      end
    end
  end
  def openingbet(your_hand,chips,minbet)
  
    probability=0
    #pair hash
    pairhash={2=>11,3=>11,4=>11,5=>12,6=>13,7=>13,8=>15,9=>16,10=>19,11=>22,12=>27,13=>32,14=>40}
    suithash={[2,3]=>7,[2,4]=>7,[2,5]=>8,[2,6]=>6,[2,7]=>6,[2,8]=>6,[2,9]=>7,[2,10]=>8,[2,11]=>8,[2,12]=>9,[2,13]=>11,[2,14]=>13,
        [3,4]=>8,[3,5]=>9,[3,6]=>8,[3,7]=>7,[3,8]=>6,[3,9]=>7,[3,10]=>8,[3,11]=>9,[3,12]=>10,[3,13]=>11,[3,14]=>14,
        [4,5]=>10,[4,6]=>10,[4,7]=>9,[4,8]=>8,[4,9]=>7,[4,10]=>8,[4,11]=>9,[4,12]=>10,[4,13]=>11,[4,14]=>14,
        [5,6]=>11,[5,7]=>10,[5,8]=>4,[5,9]=>8,[5,10]=>10,[5,11]=>9,[5,12]=>10,[5,13]=>12,[5,14]=>14,
        [6,7]=>11,[6,8]=>11,[6,9]=>10,[6,10]=>10,[6,11]=>9,[6,12]=>11,[6,13]=>12,[6,14]=>14,
        [7,8]=>12,[7,9]=>12,[7,10]=>11,[7,11]=>11,[7,12]=>11,[7,13]=>13,[7,14]=>14,
        [8,9]=>13,[8,10]=>13,[8,11]=>13,[8,12]=>13,[8,13]=>13,[8,14]=>15,
        [9,10]=>15,[9,11]=>15,[9,12]=>15,[9,13]=>15,[9,14]=>16,
        [10,11]=>18,[10,12]=>18,[10,13]=>18,[10,14]=>19,
        [11,12]=>19,[11,13]=>20,[11,14]=>20,
        [12,13]=>21,[12,14]=>22,
        [13,14]=>24}

    otherhash={[2,3]=>1,[2,4]=>2,[2,5]=>2,[2,6]=>1,[2,7]=>0,[2,8]=>0,[2,9]=>1,[2,10]=>2,[2,11]=>2,[2,12]=>3,[2,13]=>4,[2,14]=>7,
        [3,4]=>3,[3,5]=>4,[3,6]=>3,[3,7]=>1,[3,8]=>1,[3,9]=>1,[3,10]=>2,[3,11]=>2,[3,12]=>3,[3,13]=>5,[3,14]=>7,
        [4,5]=>5,[4,6]=>4,[4,7]=>3,[4,8]=>2,[4,9]=>1,[4,10]=>2,[4,11]=>3,[4,12]=>4,[4,13]=>5,[4,14]=>8,
        [5,6]=>6,[5,7]=>5,[5,8]=>4,[5,9]=>3,[5,10]=>2,[5,11]=>3,[5,12]=>4,[5,13]=>5,[5,14]=>8,
        [6,7]=>6,[6,8]=>5,[6,9]=>4,[6,10]=>4,[6,11]=>3,[6,12]=>4,[6,13]=>6,[6,14]=>7,
        [7,8]=>7,[7,9]=>6,[7,10]=>6,[7,11]=>5,[7,12]=>5,[7,13]=>6,[7,14]=>8,
        [8,9]=>8,[8,10]=>8,[8,11]=>7,[8,12]=>7,[8,13]=>7,[8,14]=>9,
        [9,10]=>10,[9,11]=>9,[9,12]=>9,[9,13]=>9,[9,14]=>10,
        [10,11]=>13,[10,12]=>12,[10,13]=>13,[10,14]=>13,
        [11,12]=>14,[11,13]=>14,[11,14]=>14,
        [12,13]=>16,[12,14]=>16,
        [13,14]=>19}


    if(community_cards)
        if(your_hand[0][:value]>==your_hand[1][:value])
            probability=pairhash[your_hand[0][:value]]
        else if(your_hand[0][:suit]==your_hand[1][:suit])
            probability=suithash[[your_hand[0][:value],your_hand[1][:value]]]
        else    
            probability=otherhash[[your_hand[0][:value],your_hand[1][:value]]]
        end
    end
    if probability>25
      amount=minbet
      raise_amount = rand(20) < 2 ? (0.1*chips).ceil : 0
      #randomly raise or bet
      if amount + raise_amount < 
        amount += raise_amount
      end
      return { :action => "bet", :amount => amount }
    elsif probability>5 and minbet< 0.5*chips
      return { :action => "bet", :amount => minbet }
    else
      if minbet==0
        return { :action => "bet", :amount => minbet }
      end
      return { :action => "fold", :amount => minbet }
    end
    
  end
  

      
    
  end
end
