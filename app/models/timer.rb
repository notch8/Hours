class Timer < ActiveRecord::Base
  belongs_to :project
  belongs_to :category
  belongs_to :user
  belongs_to :hour, required: false

  before_save :manage_hour

  private
  def manage_hour
    if ends_at_changed?
      create_hour!
    end
  end

  def create_hour!
    create_hour(
      project: self.project,
      category: self.category,
      user: self.user,
      date: self.starts_at.to_date,
      description: self.description,
      billed: self.billed,
      value: ((self.ends_at - self.starts_at) / 1.hour).round(1)
    )
  end
end
