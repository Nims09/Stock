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

FactoryGirl.define do
	factory :tweet do
		favorite_count ""
		tag_id 1
		filter_level "MyText"
		retweet_count "2"
		text "MyText"
		created_at "2015-09-13 2:31:32 +0000"
		tweeted_at "2015-09-13 2:31:32 +0000"
		sentiment 'positive'
	end

end
