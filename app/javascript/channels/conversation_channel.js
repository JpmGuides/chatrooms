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
        },
      }
    );
  }
});
