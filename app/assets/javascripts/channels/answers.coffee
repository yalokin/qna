$ ->
  App.cable.subscriptions.create 'AnswersChannel',

    connected: ->

      questionId = $('.question').data('questionId')
      if questionId
        @perform 'follow', question_id: questionId
      else
        @perform 'unfollow'
      return

    received: (data) ->
      data = {
        answer: data['answer'],
        attachments: data['attachments'],
        user: gon.current_user,
        author_id: data['author']['id']
      }
      if (gon.current_user == undefined) or ( gon.current_user.id != data['author_id'] )
        $('.answers').append JST['templates/answers/answer'](data)