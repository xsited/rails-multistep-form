class Template < ActiveRecord::Base
  has_many :hosts
  accepts_nested_attributes_for :hosts

  validates :name, presence: true, if: :step1?
  validates :regions, presence: true,  if: :step2?
  validates :deployments, presence: true,  if: :step3?
    # validates :regions, numericality: true, if: :step2?
    # validates :deployments, numericality: true, if: :step3?
  validates :hosts, presence: true, if: :step4?

  include MultiStepModel

  def self.total_steps
    4
  end

end
