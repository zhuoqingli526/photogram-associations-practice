# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#

class Photo < ApplicationRecord
  validates(:poster, { :presence => true })

  # Association accessor methods to define:
  
  ## Direct associations

  # Photo#poster: returns a row from the users table associated to this photo by the owner_id column
  belongs_to(:poster, foreign_key: "owner_id", class_name: "User")

  # Photo#comments: returns rows from the comments table associated to this photo by the photo_id column
  has_many(:comments, foreign_key:"photo_id", class_name:"Comment")

  # Photo#likes: returns rows from the likes table associated to this photo by the photo_id column
  has_many(:likes, foreign_key:"photo_id", class_name:"Like")

  ## Indirect associations

  # Photo#fans: returns rows from the users table associated to this photo through its likes
  has_many(:fans, through: :likes, source: :fan)
end
