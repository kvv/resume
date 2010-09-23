class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  # Validations
  validates_presence_of :name

end
