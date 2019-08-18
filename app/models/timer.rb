class Timer < ActiveRecord::Base
  belongs_to :project
  belongs_to :category
  belongs_to :user
  belongs_to :hour, required: false

  after_save :manage_hour

  validates :starts_at, presence: true
  validates :project, presence: true
  validates :category, presence: true
  validates :user, presence: true

  def duration_humanized
    end_time = ends_at || Time.now
    ActionView::Helpers::DateHelper.distance_of_time_in_words(end_time - starts_at)
  end

  private
  def manage_hour
    if ends_at_changed? && !hour
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
      is_client_billable: self.is_client_billable,
      value: ((self.ends_at - self.starts_at) / 1.hour).round(1)
    )
  end
end
