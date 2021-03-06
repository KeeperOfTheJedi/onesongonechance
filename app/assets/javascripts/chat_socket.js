var scheme, setupForm, uri;

scheme = location.protocol === 'http:' ? "ws://" : "wss://";

uri = scheme + window.document.location.host + "/";

window.ws = new WebSocket(uri);

window.ws.onmessage = function(message) {
  var content, current_user, data, sender_email;
  console.log("received: ", message);
  data = JSON.parse(message.data);
  console.log(current_user = $('.currentuser').text());
  content = data.content.split("TKOJ")[1];
  console.log(sender_email = data.content.split("TKOJ")[0]);
  if (sender_email !== current_user) {
    console.log(content = content.replace('ChatLog__entry ChatLog__entry_mine', 'ChatLog__entry'));
  }
  switch (data.event) {
    case 'message_create':
      return $(content).hide().appendTo('.messages').slideDown();
    case 'message_delete':
      return $('.messages').find(data.content).slideUp(300, function() {
        return $(this).remove();
      });
    default:
      return console.log("unknown event", data.event);
  }
};

setupForm = function() {
  console.log("setupForm");
  $("form#new_message").on('ajax:success', function(event, data, success, xhr) {
    console.log("ajax success");
    $('input#message_content').val('');
  }).on('ajax:error', function(event, xhr, status, error) {
    return alert("Couldn't send the message. Try again later.");
  });
  return $('.message_delete').on('ajax:before', function() {
    return $(this).parent().slideUp('slow');
  }).on('ajax:error', function(event, xhr, status, error) {
    console.log("Error: ", error);
    return $(this).parent().effect('shake');
  });
};

$(document).on("page:change", function() {
  return setupForm();
});