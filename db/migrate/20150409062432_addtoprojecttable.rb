class Addtoprojecttable < ActiveRecord::Migration
  def change
    add_column :projects, :title, :string
    add_column :projects, :category, :string
    add_column :projects, :image_url, :string
    add_column :projects, :about, :string
  end
end
