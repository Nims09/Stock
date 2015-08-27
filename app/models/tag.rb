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

	end
end
