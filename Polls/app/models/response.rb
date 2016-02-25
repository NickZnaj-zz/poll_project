class Response < ActiveRecord::Base

  validate :respondent_already_answered?
  validate :no_rigging

  belongs_to(
    :respondent,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id
  )

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    primary_key: :id,
    foreign_key: :answer_choice_id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def sibling_responses
    question.responses.where.not(id: id)
  end

  def respondent_already_answered?
    if sibling_responses.exists?(user_id: user_id)
      errors[:user_id] << "Already answered this poll"
    end
  end

  def no_rigging
   if question.poll.user_id == user_id
     errors[:user_id] << "Rigger no rigging"
   end
  end
end
