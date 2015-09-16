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
#

class Tweet < ActiveRecord::Base

	belongs_to :tag

end
