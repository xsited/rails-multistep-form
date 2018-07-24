FactoryGirl.define do

  factory :template do
    name 				"Awesome template"												# name
    regions  			"us-west-1 eu-central-1 ap-southeast-2 ca-central-1	us-west-2"  # list of regions (1)
    networks 			"default protected" 											# list of shared (1) and protected (1) per region
    deployments 		"network hipswitch relay conductor conductorha host" 			# list of deploments (any deployment in shared hipswitch and host in protected)
    hosts 				"ubuntu centos debian amazon redhat" 							# list of hosts (3) [ ubuntu ubuntu centos ]
    # XXX - who owns build_list	method
    # hosts { build_list :hosts, 1 }
  end

  factory :host do
    name "ubuntu"
    # url  "https//localhost:3000"
    # filename tnw_deployment.tgz
    # application "wget #{url}/#{filename}; dpkg -i #{filename}; ./install_cl_app.sh"
  end

end
