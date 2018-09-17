# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string           default(""), not null
#  created_at  :datetime
#  updated_at  :datetime
#  slug        :string
#  budget      :integer
#  billable    :boolean          default("false")
#  client_id   :integer
#  archived    :boolean          default("false"), not null
#  description :text
#

class Project < ActiveRecord::Base
  include Sluggable

  audited allow_mass_assignment: true

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates_with ClientBillableValidator
  has_many :hours
  has_many :mileages
  has_many :rates
  has_many :users, -> { uniq }, through: :hours
  has_many :categories, -> { uniq }, through: :hours
  has_many :tags, -> { uniq }, through: :hours
  belongs_to :client, touch: true
  accepts_nested_attributes_for :rates, reject_if: :all_blank

  scope :by_last_updated, -> { order("projects.updated_at DESC") }
  scope :by_name, -> { order("lower(name)") }

  scope :are_archived, -> { where(archived: true) }
  scope :unarchived, -> { where(archived: false) }
  scope :billable, -> { where(billable: true) }

  def sorted_categories
    categories.sort_by do |category|
      EntryStats.new(hours, category).percentage_for_subject
    end.reverse
  end

  def label
    name
  end

  def budget_status
    budget - hours.sum(:value) if budget
  end

  def has_billable_entries?
    hours.exists?(billed: false) ||
      mileages.exists?(billed: false)
  end

  def dollar_budget_status
    amount = []
    hours.each do |h|
      rates.each do |r|
        amount << (h.value * r.amount).round(2) if h.user_id == r.user_id && r.amount
      end
    end
    amount.any? ? budget - amount.sum : budget
  end

  def amount_per_entry_user(hour)
    if use_dollars
      amount = 0
      rates.each do |r|
        amount = hour.value.to_f * r.amount.to_f if hour.user_id == r.user_id
      end
      amount
    end
  end

  private

  def slug_source
    name
  end
end
