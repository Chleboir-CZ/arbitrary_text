require "arbitrary_text"

describe ArbitraryText do
	before do
		@arb_array = Array.new
		@arb_array.push(ArbitraryText.new("spec/sample_full.txt"))
		@arb_empty = ArbitraryText.new("spec/sample_empty.txt")
	end

	describe "#new" do
		it "takes an existing filename and returns an ArbitraryText object" do
			@arb_array.each do |arb|
				expect(arb).to be_an_instance_of ArbitraryText
			end
			expect(@arb_empty).to be_an_instance_of ArbitraryText
		end
	end

	describe "#get_markov_chain" do
		it "returns a chain of correct length" do
			@arb_array.each do |arb|
				r = rand(1..400)
				chain = arb.get_markov_chain(r)
				expect(chain.split.size).to eq(r)
			end
			r = rand(1..400)
			chain = @arb_empty.get_markov_chain(r)
			expect(chain.split.size).to eq(0)
		end

		it "returns a correctly formatted chain" do
			@arb_array.each do |arb|
				r = rand(1..400)
				array = arb.get_markov_chain(r).split(" ")
				expect(array[0]).to eq(array[0].capitalize)
				for x in 0..array.size - 2
					if array[x][-1] == "."
						expect(array[x + 1]).to eq(array[x + 1].capitalize)
					end
				end
				expect(array[-1][-1]).to eq(".")
			end
		end
	end

	describe "#get_sentence" do
		before do
			@str_array = Array.new
			@arb_array.each do |arb|
				@str_array.push(arb.get_sentence)
			end
			@str_empty = @arb_empty.get_sentence
		end

		it "returns a string" do
			@str_array.each do |str|
				expect(str).to be_an_instance_of String
			end
			expect(@str_empty).to be_an_instance_of String
		end

		it "returns a correnctly formatted sentence" do
			@str_array.each do |str|
				expect(str).to eq(str.capitalize)
				expect(str[-1]).to eq(".")
			end
			expect(@str_empty).to eq("")
		end
	end
end
