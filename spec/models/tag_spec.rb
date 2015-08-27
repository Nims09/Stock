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

require 'rails_helper'

describe Tag do 

	context "validates" do 

		it "has a valid factory" do 
			expect(FactoryGirl.create(:tag)).to be_valid
		end 

	end

end 