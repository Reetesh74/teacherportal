class Student < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, format: { with: /\A[^\d]*\z/, message: "only allows letters" }
  validates :marks, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: "must be a number between 0 and 100" }
end
