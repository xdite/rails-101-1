class Group < ApplicationRecord
  belongs_to :user
  has_many :posts
  validates :title, presence: true

  has_many :group_relationships
  has_many :participated_groups, :through => :group_relationships, :source => :group


    def join!(group)
      participated_groups << group
    end

    def quit!(group)
      participated_groups.delete(group)
    end
        
end
