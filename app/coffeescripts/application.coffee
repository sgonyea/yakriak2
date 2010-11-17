$ =>
  if $('#comments').length > 0
    setTimeout updateComments, 10000

updateComments = () ->
  $.getScript '/comments.js'
  setTimeout updateComments, 10000

replaceYak = (new_yak) ->
  $('#yak').html(new_yak)

highlightName = () ->
  $('#name').addClass 'required'

displayMessage = (item) ->
  return if $("##{item['key']}").length != 0

  elem      = $("<li id=\"#{item['key']}\" />")
  avatar    = $('<img />').attr 'src', "http://gravatar.com/avatar/#{item['gravatar']}?s=40"
  name      = $('<span class="name">').html item['name']
  message   = $('<span class="message">').html item['message']
  timestamp = $('<span class="timestamp">').text new Date(item['timestamp']).toLocaleTimeString

  elem
    .append(timestamp)
    .append(avatar)
    .append(name)
    .append(message)

  elem.addClass 'me' if item['name'] == $.cookie("name") and item['gravatar'] == $.cookie("gravatar")

  $('ol#chatlog').append    elem
  $('ol#chatlog').scrollTop elem.position.top

didPostItem = (item) ->
  displayMessage item
  $('input#message').val ''
