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


class AnalyzedText
	def initialize(raw_string)
		@words = parse_raw_string(raw_string)
	end

	private
		def parse_raw_string(raw_string)
			return_hash = {}
			split_str = raw_string.split(" ")
			for word_str in split_str
				if return_hash[word_str] == nil
					word_obj = Word.new(word_str)
					for word in split_str
						if word == word_str
							# increase probability of the word
							word_obj.inc_prob
							# get index of next word
							index = split_str.index(word) + 1
							# add to next words
							if split_str[index] != nil
								word_obj.add_next_word(split_str[index])
							end
						end
					end
					word_obj.dec_prob
					return_hash[word_str] = word_obj
				end
			end
			return return_hash;
		end
end
