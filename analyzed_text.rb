require_relative 'word'

class AnalyzedText
	def initialize(raw_string)
		@words = parse_raw_string(raw_string)
		@word_probability_sum = 0

		@words.each_value do |word|
			@word_probability_sum += word.probability
		end
	end

	def get_markov_str(length)
		word = get_first_word()
		str = word.str
		for x in 1..length
			if (word = word.next) != nil
				str = str + " " + word.str
			else
				break
			end
		end
		return str
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
						end
					end
					word_obj.dec_prob
					return_hash[word_str] = word_obj
				end
			end
			# add next words
			for word in split_str
				index = split_str.index(word)
				if split_str[index + 1] != nil
					return_hash[split_str[index]].add_next_word(return_hash[split_str[index + 1]])
				end
			end
			return return_hash;
		end

		def get_first_word
			rand_num = rand(1..@word_probability_sum)
			i = 0
			@words.each_value do |word|
				if rand_num >= i and rand_num <= i + word.probability
					return word
				else
					i += word.probability
				end
			end
		end
end


raw_text = gets()
if raw_text == nil
	raise 'piču'
end
analyzed = AnalyzedText.new(raw_text)
puts(analyzed.get_markov_str(50))

