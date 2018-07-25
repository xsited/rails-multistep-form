class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table      :templates do |t|
      t.string        :name
      t.text          :description
      t.string        :regions
      t.string        :deployments
      t.string        :hosts
      t.timestamps
    end
  end
end
