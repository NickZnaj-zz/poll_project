# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
dan = User.create!(user_name: 'Dan')
nick = User.create!(user_name: 'Nick')

Poll.destroy_all
important_poll = nick.authored_polls.create!(title: 'Help picking favorite colors')

Question.destroy_all
question1 = important_poll.questions.create!(text: "What is Dan's Favorite color?")
question2 = important_poll.questions.create!(text: "What is Nick's favorite color?")

AnswerChoice.destroy_all
choice11 = question1.answer_choices.create!(text: "Green")
choice12 = question1.answer_choices.create!(text: "Blue")
choice13 = question1.answer_choices.create!(text: "Red")

choice21 = question2.answer_choices.create!(text: "Green")
choice22 = question2.answer_choices.create!(text: "Blue")
choice23 = question2.answer_choices.create!(text: "Red")

Response.destroy_all
choice12.responses.create!(user_id: dan.id)
choice23.responses.create!(user_id: dan.id)
