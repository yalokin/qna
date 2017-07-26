$ ->
  $(".vote-link").bind "ajax:success", (e) ->
    obj = $.parseJSON(e.detail[2].response)
    $('#' + obj.controller + '-rating-'  + obj.id).html(obj.content)