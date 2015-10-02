# == Schema Information
#
# Table name: tweets
#
#  id             :integer          not null, primary key
#  favorite_count :integer
#  filter_level   :text
#  retweet_count  :integer
#  text           :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  tweeted_at     :datetime
#  tag_id         :integer
#  sentiment      :string
#

# TODO : Maybe abstract this logic to the Tag, so a new initializer doesn't need to be created each tweet
require "sentimentalizer"

class Tweet < ActiveRecord::Base
	belongs_to :tag

	validates :text, presence: true
	validates :tweeted_at, presence: true
	validates :tag_id, presence: true
	validates_inclusion_of :sentiment, :in => ['positive', 'negative', 'neutral'], :allow_nil => false

	SENTIMENTS = ['positive', 'negative', 'neutral']

	def self.sentiments
		SENTIMENTS
	end

	def determine_sentiment	
		self.sentiment = translate_sentiment(Sentimentalizer.analyze(self.text).sentiment)
	end

	private 

	def translate_sentiment(sentiment_as_emoji)
		case sentiment_as_emoji
		when ':)'
			'positive'
		when ':('
			'negative'
		when ':|'
			'neutral'
		else
			'INVALID'
		end
	end
end
