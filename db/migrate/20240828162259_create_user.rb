class CreateUser < ActiveRecord::Migration[6.1]
  def change
    
    #   create_table :accounts do |t|
    #   t.string :name
    #   t.string :email
    #   t.string :password
    # end
    
    create_table :posts do |t|
      t.string :content
    end
    
    create_table :comments do |t|
      t.string :content
      t.integer :post_id
      t.integer :user_id
    end
  end
end
