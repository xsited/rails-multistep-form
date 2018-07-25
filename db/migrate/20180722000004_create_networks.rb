class CreateNetworks < ActiveRecord::Migration[5.2]
  def change
    create_table 	    :networks do |t|
      t.string 		    :name
      t.string   	    :network_cidr
      t.string   	    :shared_subnet_cidr
      t.string   	    :protected_subnet_cidr

      t.string        :network_id
      t.string        :shared_subnet_id
      t.string        :protected_subnet_id
      t.string        :az_id

      t.references 	  :templates, index: true

      t.timestamps
    end
  end
end
