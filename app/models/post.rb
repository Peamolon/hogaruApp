class Post < ApplicationRecord
     belongs_to :owner, class_name: 'User'
    validates :content, :seen,  presence: true
    validates :content, length: { maximum: 140 }
end
