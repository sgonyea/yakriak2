var didPostItem, displayMessage, highlightName, replaceYak, updateComments;
var __bind = function(func, context) {
    return function(){ return func.apply(context, arguments); };
  };
$(__bind(function() {
  return $('#comments').length > 0 ? setTimeout(updateComments, 10000) : null;
}, this));
updateComments = function() {
  $.getScript('/comments.js');
  return setTimeout(updateComments, 10000);
};
replaceYak = function(new_yak) {
  return $('#yak').html(new_yak);
};
highlightName = function() {
  return $('#name').addClass('required');
};
displayMessage = function(item) {
  var avatar, elem, message, name, timestamp;
  if ($("#" + (item['key'])).length !== 0) {
    return null;
  }
  elem = $("<li id=\"" + (item['key']) + "\" />");
  avatar = $('<img />').attr('src', "http://gravatar.com/avatar/" + (item['gravatar']) + "?s=40");
  name = $('<span class="name">').html(item['name']);
  message = $('<span class="message">').html(item['message']);
  timestamp = $('<span class="timestamp">').text(new Date(item['timestamp']).toLocaleTimeString());
  elem.append(timestamp).append(avatar).append(name).append(message);
  if (item['name'] === $.cookie("name") && item['gravatar'] === $.cookie("gravatar")) {
    elem.addClass('me');
  }
  $('ol#chatlog').append(elem);
  return $('ol#chatlog').scrollTop(elem.position.top);
};
didPostItem = function(item) {
  displayMessage(item);
  return $('input#message').val('');
};