class CreateTweets < ActiveRecord::Migration
  
  def change
    create_table :tweets do |t|
      t.belongs_to :user
      t.text :content
    end
  end

end
