module TweetHelpers
	def unprocessed_tweets(count, name, start_date, end_date)
		tweets = []

		count.times do |index|
			tweet = OpenStruct.new

			tweet.favorite_count = "3"
			tweet.filter_level = "high"
			tweet.retweet_count = "12"
			tweet.text = "#{name}"

			if index == 0
				tweet.created_at = start_date
			elsif index == (count-1)
				tweet.created_at = end_date
			else
				tweet.created_at = start_date
			end

			tweets.push tweet
		end

		tweets
	end
end