$(document).on 'page:change', ->
  console.log 'on page:change'
  $("#youtube_video").fitVids();