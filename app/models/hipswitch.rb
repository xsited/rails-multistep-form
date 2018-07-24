class Hipswitch < ActiveRecord::Base
  belongs_to :template

  validates :name, presence: true

end
