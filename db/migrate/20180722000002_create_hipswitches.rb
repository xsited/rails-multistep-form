class CreateHipswitches < ActiveRecord::Migration[5.2]
  def change
    create_table 	    :hipswitches do |t|
      t.string 		    :name
      t.string   	    :image_id
      t.string   	    :machine_type_id
      t.string   	    :shared_subnet_id
      t.string   	    :protected_subnet_id
      t.string   	    :conductor_id
      t.string        :az_id

      t.references 	  :templates, index: true

      t.timestamps
    end
  end
end
