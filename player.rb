class Player
	attr_accessor :cards, :name

	def initialize (name)
		self.cards = []
		self.name = name
	end

	def total
		total = 0
		self.cards.each do |card|
			total += card[:value]	
		end
		total
	end

	#extremely simple a.i.
	def action
		if self.total >= 17
			return "stand"
		 end
		 "hit"
	end

	def blackjack?
		if self.total == 21
			return true
		end
		return false
	end

	def busted?
		if self.total > 21
			return true
		end
		false
	end

	def to_s
		puts "#{self.name} has #{self.total} points."
	end

end



