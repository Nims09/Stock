# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  sentiment  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
	has_many :tweets

	validates :name, presence: :true

	# TODO : Needs tweet object, as this will generate initial batch
	# 	=> Need to think about how this is done intially
	# 	=> Perhaps come to some specified winow, or how do we know how many initial tweets we need, initial analysis 	
	def intiate_sentiment

		search = get_tweets_in_time_range( "#justin", (Time.now-1.weeks), Time.now)

		search.each do |tweet|
			puts tweet.text
		end

		puts search.count

	end

	private

	# TODO : =>	This needs to be replaced by web scraping. 
	# 			The API simply does not cover the needs for 
	# 			an application like this with the strict 
	# 			limits. We will use the gem for now. 
	# 		 => This limit appears to be with the NUMBER of
	# 			requests you, not the actual amount of tweets
	# 			being returned in each
	def get_tweets_in_time_range(search, since_time, until_time)
		client = TwitterAPI.new.client

		begin

			return client.search(
				search,
				include_entities: true,
				result_type: "recent",
				since: since_time.to_date, 
				until: until_time.to_date
			)
		rescue Twitter::Error::Unauthorized
			puts "Unauthorized credentials"

			return []
		end
	end 
end
