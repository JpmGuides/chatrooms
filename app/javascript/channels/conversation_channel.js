import consumer from "./consumer";

document.addEventListener("turbolinks:load", () => {
  const element = document.getElementById("chat");

  if (element) {
    const conversationId = element.dataset.conversationId;

    consumer.subscriptions.create(
      { channel: "ConversationChannel", room_id: conversationId },
      {
        connected() {
          // Called when the subscription is ready for use on the server
          console.log("connected");
        },

        disconnected() {
          // Called when the subscription has been terminated by the server
        },

        received(data) {
          // Called when there's incoming data on the websocket for this channel

          let chat = document.getElementById("chat-messages");
          let newNode = document.getElementById('chat-message-exemple').cloneNode(true);
          let messageContentContainer = newNode.querySelector('.chat-message-content');
          let mediaContainer = newNode.querySelector(".chat-message-content-media");
          let representableMedia = newNode.querySelector(".chat-message-content-media-representable");
          let urlMedia = newNode.querySelector(".chat-message-content-media-url");

          newNode.removeAttribute('id');
          newNode.hidden = false;
          newNode.querySelector(".chat-message-content-text").innerText = data.message;
          newNode.querySelector(".chat-message-author").innerText = data.author;


          if(data.media.url) {
            if(data.media.media_is_representable){
              representableMedia.src = data.media.url;
              representableMedia.alt = data.media.media_filename;
              mediaContainer.removeChild(urlMedia);
            }else{
              urlMedia.href = data.media.url;
              urlMedia.innerText = data.media.media_filename;
              mediaContainer.removeChild(representableMedia);
            }
          }else{
            messageContentContainer.removeChild(mediaContainer);
          }

          chat.appendChild(newNode);
        },
      }
    );
  }
});
