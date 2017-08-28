class Word
	def initialize(word)
		@first_word_probability = 1
		@word = word
		@possible_next_words = {}
		@next_probabilities_sum = 0
		@ends_sentence = (word[-1] == ".")
	end

	def inc_first_prob
		@first_word_probability += 1
	end

	def first_word_probability
		return @first_word_probability
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
			@possible_next_words.each_value do |word_and_prob|
				if rand_num >= i and rand_num < i + word_and_prob[1]
					return word_and_prob[0]
				else
					i += word_and_prob[1]
				end
			end
		end
		return nil
	end

	def add_next_word(word)
		if @possible_next_words[word.str] == nil
			@possible_next_words[word.str] = [word, 1]
		else
			@possible_next_words[word.str][1] += 1
		end
		@next_probabilities_sum += 1
	end
end
