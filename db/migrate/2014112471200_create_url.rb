class CreateUrl < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :short_url, :long_url
      t.timestamps
    end
  end
end