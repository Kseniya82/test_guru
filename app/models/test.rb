class Test < ApplicationRecord
  belongs_to :category
  belongs_to :creater, class_name: "User", foreign_key: "user_id", inverse_of: :own_tests

  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages, dependent: :destroy

  validates :title, presence: true
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, uniqueness: { scope: :level }
  validates :time_limit, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 3599 }, if: :timer?

  scope :easy, -> { where(level: 0..1) }
  scope :midle, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }
  scope :select_by_category, -> (title) { joins(:category).where(categories: { title: title }).order(title: :desc) }

  def self.select_title_by_category(title)
    select_by_category(title).pluck(:title)
  end

  private

  def timer?
    time_limit.present?
  end
end
