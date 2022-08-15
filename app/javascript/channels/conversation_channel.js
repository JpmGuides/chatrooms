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
          console.log(data);

          var lastData = data

          let chat = document.getElementById("chat-messages");
          let newNode = document.getElementById('chat-message-exemple').cloneNode(true);
          let messageContentContainer = newNode.querySelector('.chat-message-content');
          

          newNode.removeAttribute('id');
          newNode.hidden = false;
          newNode.querySelector(".chat-message-content-text").innerText = data.message;
          newNode.querySelector(".chat-message-author").innerText = data.author;

          if(data.media){

            let mediaContainer = newNode.querySelector(".chat-message-content-media");
            let mediaSample = newNode.querySelector(".chat-message-content-media-media.sample");
            

            data.media.forEach(media => {
              let mediaNode = mediaSample.cloneNode(true);
              let representableMedia = mediaNode.querySelector(".chat-message-content-media-representable");
              let urlMedia = mediaNode.querySelector(".chat-message-content-media-url");

              mediaNode.classList.remove('sample');

              if(media.representable){
                representableMedia.src = media.url;
                representableMedia.alt = media.filename;
                mediaNode.removeChild(urlMedia);
              }else{
                urlMedia.href = media.url;
                urlMedia.innerText = media.filename;
                mediaNode.removeChild(representableMedia);
              }
              
              mediaContainer.appendChild(mediaNode);
              
            });
          }else{
            messageContentContainer.removeChild(mediaContainer);
          }
          

          chat.appendChild(newNode);
        },
      }
    );
  }
});
