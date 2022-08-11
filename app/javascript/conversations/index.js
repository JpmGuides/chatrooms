document.addEventListener("turbolinks:load", () => {
  const chat = document.getElementById("chat");
  if (chat) {
    chat.querySelector(".chat-form-text").addEventListener("submit", (e) => {
      const form = e.target;

      // Post data using the Fetch API
      fetch(form.action, {
        method: form.method,
        body: new FormData(form),
      });

      // Prevent the default form submit
      e.preventDefault();

      // Clear the form text
      form.reset();
    });
  }
});
