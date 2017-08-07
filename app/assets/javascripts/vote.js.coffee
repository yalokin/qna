$ ->
  $(".vote-link").bind "ajax:success", (e) ->
    obj = e.detail[0]
    $('#' + obj.votable_type + '-rating-'  + obj.id).html(obj.content)