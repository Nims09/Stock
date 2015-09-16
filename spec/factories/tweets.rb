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

FactoryGirl.define do
  factory :tweet do
    favorite_count ""
filter_level "MyText"
retweet_count ""
text "MyText"
created_at ""
  end

end
