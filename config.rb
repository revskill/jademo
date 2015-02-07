require 'active_record'
require 'sqlite3'
require 'iso-639'
#https://drive.google.com/open?id=0B-Ls2Z1D5igvTjJMeExtczF6bmc&authuser=0
#https://drive.google.com/uc?export=download&id=0B-Ls2Z1D5igvTjJMeExtczF6bmc
ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3', # or 'postgresql' or 'sqlite3'
  :database => 'server.db'
)

ActiveRecord::Schema.define do  
 
  unless ActiveRecord::Base.connection.tables.include? 'apps'
    create_table :apps do |table|
      table.column :name ,    :string
      table.column :identifier ,   :string  
      table.column :url ,   :string            
    end
  end
  unless ActiveRecord::Base.connection.tables.include? 'categories'
    create_table :categories do |table|
      table.column :app_id   ,  :integer
      table.column :name  ,   :string
      table.column :identifier  ,   :string
      table.column :url  ,   :string
    end
  end
end
class App < ActiveRecord::Base
  has_many :categories
end
class Category < ActiveRecord::Base
  belongs_to :app
end
