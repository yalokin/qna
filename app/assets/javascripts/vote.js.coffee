$ ->
  $(".vote-link").bind "ajax:success", (e) ->
    obj = e.detail[0]
    $('#' + obj.controller + '-rating-'  + obj.id).html(obj.content)