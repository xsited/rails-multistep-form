FactoryGirl.define do

  factory :template do
    name "Awesome template"
    regions  "hipswitch relay host conductor conductorha"
    deployments "hipswitch relay host conductor conductorha"
    hosts "ubuntu centos"
    networks "default protected"
    # hosts { build_list :hosts, 1 }
  end

  factory :host do
    name "ubuntu"
  end

end