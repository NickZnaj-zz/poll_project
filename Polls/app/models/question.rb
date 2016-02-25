class Question < ActiveRecord::Base
  validates :text, presence: true

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    primary_key: :id,
    foreign_key: :question_id
  )

  belongs_to(
    :poll,
    class_name: 'Poll',
    primary_key: :id,
    foreign_key: :poll_id
  )

  has_many(
  :responses,
  through: :answer_choices,
  source: :responses
  )

  def results
    # (<<-SQL, id)
    # select
    #   answer_choices.*, COUNT(user.id)
    # from
    #   answer_choices
    # left outer join
    #   responses on responses.answer_choice_id = answer_choices.id
    # where
    #   answer_choices.question_id = ?
    # group by
    #   answer_choices.id
    # SQL
    result_hash = {}
    self.answer_choices
      .joins("LEFT OUTER JOIN responses on responses.answer_choice_id = answer_choices.id ")
      .group("answer_choices.id")
      .select("answer_choices.*, COUNT(responses.user_id) AS votes")
      .each do |answer_choice|
        result_hash[answer_choice] = answer_choice.votes
      end

    result_hash
  end
end
