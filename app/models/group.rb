class Group < ApplicationRecord
  belongs_to :user
  has_many :posts
  validates :title, presence: true

  has_many :group_relationships
  has_many :participated_groups, :through => :group_relationships, :source => :group
    
end
