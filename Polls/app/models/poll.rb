class Poll < ActiveRecord::Base

  has_many(
    :questions,
    class_name: 'Question',
    primary_key: :id,
    foreign_key: :poll_id
  )

  belongs_to(
    :author,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id
  )
end