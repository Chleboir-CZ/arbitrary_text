require_relative "word"

SENTENCE_LENGTH = 10

class ArbitraryText
	def initialize(raw_string)
		@words = parse_raw_text(raw_string)
		@word_probability_sum = 0

		@words.each_value do |word|
			@word_probability_sum += word.first_word_probability
		end
	end

	def get_markov_chain(length)
		word = get_first_word
		str = ""
		if word != nil
			for x in 1..length
				str = str + " " + word.str
				word = word.next
				if word == nil
					word = get_first_word
				end
			end
		end
		str = format_sentences(str)
		return str
	end

	def get_sentence
		word = get_first_word
		str = ""
		if word != nil
			str = str + word.str
			i = 0
			loop do
				break if word.ends_sentence
				word = word.next
				i += 1
				str = str + " " + word.str
				if i == SENTENCE_LENGTH
					str = str + "."
					break
				end
			end
		end
		return str.capitalize
	end

	private
		def parse_raw_text(filename)
			return_hash = {}
			raw_str = get_raw_str(filename)
			split_str = raw_str.split(" ")
			get_first_word_probabilities(split_str, return_hash)
			add_next_words(split_str, return_hash)
			return return_hash
		end

		def get_first_word_probabilities(split_str, return_hash)
			for word_str in split_str
				if return_hash[word_str] == nil
					return_hash[word_str] = Word.new(word_str)
				else
					return_hash[word_str].inc_first_prob
				end
			end
		end

		def add_next_words(split_str, hash)
			for i in 0..split_str.size - 1
				j = i + 1 # index of next word
				if split_str[j] != nil
					hash[split_str[i]].add_next_word(hash[split_str[j]])
				end
			end
		end

		def get_raw_str(filename)
			raw_str = ""
			File.readlines(filename).each do |line|
				raw_str += (" " + line)
			end
			return raw_str
		end

		def get_first_word
			rand_num = rand(1..@word_probability_sum)
			i = 0
			@words.each_value do |word|
				if rand_num >= i and rand_num <= i + word.first_word_probability
					return word
				else
					i += word.first_word_probability
				end
			end
			return nil
		end

		def format_sentences(markov_ch)
			if markov_ch != ""
				array = markov_ch.split(" ")
				array[0].capitalize!
				for x in 0..array.length - 2
					if array[x][-1] == "."
						array[x + 1].capitalize!
					end
				end
				ret_chain = array.join(" ")
				ret_chain << "."
				return ret_chain
			else
				return markov_ch
			end
		end
end
