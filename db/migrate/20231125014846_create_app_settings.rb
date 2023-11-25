class CreateAppSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :app_settings do |t|
      t.integer  :singleton_guard
      t.string :config_property1
      t.string :config_property2
      t.timestamps
    end
    
    add_index(:app_settings, :singleton_guard, :unique => true)
  end
end
