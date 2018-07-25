require 'spec_helper'

describe Template do
  let(:template) { FactoryGirl.build(:template) }
  subject { template }

  it "should be valid and save" do
    expect(template).to be_valid
    expect(template.save).to be_truthy
  end

  it "should have errors if invalid" do
    required_fields = [:name, :deployments, :hosts]
    required_fields.each { |field| template[field] = nil }
    expect(template).to_not be_valid
    required_fields.each { |field| expect(template.errors).to have_key(field) }
  end
  
end