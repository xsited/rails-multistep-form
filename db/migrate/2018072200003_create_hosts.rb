class CreateHosts < ActiveRecord::Migration[5.2]
  def change
    create_table 	      :hosts do |t|
      t.string 		      :name
      t.string   	      :image_id
      t.string   	      :machine_type_id
      t.string          :protected_subnet_id
      t.text     	      :custom_application
      t.references 	    :templates, index: true

      t.timestamps
    end
  end
end
