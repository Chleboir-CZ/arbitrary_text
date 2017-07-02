class Word
	def initialize(word)
		@probability = 1
		@word = word
		@possible_next_words = {}
		@next_probabilities_sum = 0
		@ends_sentence = (word[-1] == ".")
	end

	def inc_prob()
		@probability += 1
	end

	def dec_prob()
		@probability -= 1
	end

	def probability()
		return @probability
	end

	def ends_sentence
		return @ends_sentence
	end

	def str
		return @word
	end
	
	# gets the continuing word in a sentence
	def next()
		rand_num = rand(1..@next_probabilities_sum)
		i = 1
		if @possible_next_words != nil
			@possible_next_words.each_value do |word|
				if rand_num >= i and rand_num < i + word.probability
					return word
				else
					i += word.probability
				end
			end
		end
		return nil
	end

	def add_next_word(word)
		if @possible_next_words[word.str] == nil
			@possible_next_words[word.str] = word
		else
			@possible_next_words[word.str].inc_prob()
		end
		@next_probabilities_sum += 1
	end
end
