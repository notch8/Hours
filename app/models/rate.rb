class Rate < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  accepts_nested_attributes :project
end
