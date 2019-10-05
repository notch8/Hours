class User < ActiveRecord::Base
  include Sluggable

  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :invitable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtBlacklist

  validates_presence_of :first_name, :last_name

  has_one :account, foreign_key: "owner_id", inverse_of: :owner
  belongs_to :organization, class_name: "Account", inverse_of: :users
  has_many :timers
  has_many :hours
  has_many :mileages
  has_many :projects, -> { uniq }, through: :hours
  has_many :rates

  scope :by_name, -> { order("lower(last_name)") }

  def full_name
    "#{first_name} #{last_name}"
  end
  alias_method :slug_source, :full_name
  alias_method :label, :full_name
  alias_method :name, :full_name

  def email_domain
    email.split("@").last
  end

  def color
    (first_name + last_name).pastel_color
  end

  def acronyms
    first_name[0] + last_name[0]
  end

  def active_timer
    timers
      .where(ends_at: nil)
      .last
  end
end
