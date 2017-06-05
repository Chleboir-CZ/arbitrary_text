class Word
	def initialize(word)
		@probability = 1
		@word = word
		@possible_next_words = {}
		@next_probabilities_sum = 0
	end

	def inc_prob()
		@probability += 1
	end

	def dec_prob()
		@probability -= 1
	end

	def add_next_word(word)
		if @possible_next_words[word] == nil
			word_obj = Word.new(word)
			@possible_next_words[word] = word_obj
		else
			@possible_next_words[word].inc_prob()
		end
		@next_probabilities_sum += 1
	end
end
