class User < ActiveRecord::Base
  validates :user_name, presence: true
  validates :user_name, uniqueness: true

  has_many(
    :authored_polls,
    class_name: 'Poll',
    primary_key: :id,
    foreign_key: :user_id
  )

  has_many(
    :responses,
    class_name: 'Response',
    primary_key: :id,
    foreign_key: :user_id
  )
end
