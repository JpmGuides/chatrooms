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
          let chat = document.getElementById("chat-messages");
          let newNode = chat.querySelector(".chat-message").cloneNode(true);
          newNode.querySelector(".chat-message-content-text").innerText = data.message;
          newNode.querySelector(".chat-message-author").innerText = data.author;
          chat.appendChild(newNode);
        },
      }
    );
  }
});
