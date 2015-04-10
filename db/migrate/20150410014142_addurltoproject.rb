class Addurltoproject < ActiveRecord::Migration
  def change
    add_column :projects, :theurl, :string
  end
end
