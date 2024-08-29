require 'bundler/setup'
require 'bcrypt'
require 'active_record'

Bundler.require

ActiveRecord::Base.establish_connection

    class User < ActiveRecord::Base
        has_secure_password
        validates :name, presence: true
        validates :mail, presence: true
        validates :password, length: { in: 5..10 }
        has_many :posts
        has_many :comments
    end
    
    class Post < ActiveRecord::Base
        belongs_to :user
        has_many :comments
    end
    
    class Comment < ActiveRecord::Base
        belongs_to :user
        belongs_to :post
    end