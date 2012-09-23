require './player'

class Blackjack
	attr_accessor :player, :dealer, :deck

	def initialize
		self.deck = buildDeck
		self.player = Player.new("Player")
		self.dealer = Player.new("Dealer")
		self.deal
		self.round
	end

	def deal
		2.times do 
			self.player.cards << self.deck.pop
			self.dealer.cards << self.deck.pop
		end
	end

	def buildDeck
		suits = ["hearts","spades","diamonds","clubs"]	
		cards = {"two" => 2, "three" => 3, "four" => 4,
				  "five" => 5, "six" => 6, "seven" => 7,
				  "eight" => 8, "nine" => 9, "jack" => 10,
				  "queen" => 10, "king" => 10, "ace" => 11}
		deck = []

		suits.each do |suit|
			cards.each do |title, value|
				deck << {:suit => suit, :value => value, :title => title}
			end
		end
		deck.shuffle!
	end

	def play (player)
		
		# check player action, switch statement: if hit, perform hit, if stand, end their play
		while (true)
			case player.action
			when "hit"
				player.cards << self.deck.pop
				puts "#{player.name} hits and now has #{player.total} points"
			when "stand"
				puts "#{player.name} stands with #{player.total} points"
				break
			end
		end
	end

	def round
		if self.player.blackjack?
			puts "Player scores a blackjack!"
			return self.player
		end

		if self.dealer.blackjack?
			puts "Dealer scores a blackjack!"
			return self.dealer
		end

		play(self.player)
		if self.player.busted? 
			puts "Player busts with #{self.player.total} points. Dealer wins!"
			return self.dealer
		end

		play(self.dealer)
		if self.dealer.busted? 
			puts "Dealer busts with #{self.dealer.total} points. Player wins!"
			return self.player
		end

		if(self.player.total > self.dealer.total)
			puts "Player wins the hand #{self.player.total} points against #{self.dealer.total}"
			return self.player
		end
		puts "Dealer wins the hand #{self.dealer.total} points against #{self.player.total}!"
		self.dealer
	end

end