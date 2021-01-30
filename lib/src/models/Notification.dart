class Notification {
  final String message;
  final String time;

  Notification(this.message, this.time);

  Notification.dummy()
      : this.message = "Lorem ipsum dolor sit amet",
        this.time = "20 Sep";
}
