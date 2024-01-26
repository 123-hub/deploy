class MessageContent {
  late String joinerMessage;
  late String organizerMessage;
  late DateTime time;

  MessageContent.fromJson(json) {
    joinerMessage = json['joiner_message'];
    organizerMessage = json['organizer_message'];
    time = DateTime.parse(json['created_at']);
  }

  MessageContent({
    required this.joinerMessage,
    required this.organizerMessage,
    required this.time,
  });

  @override
  String toString() {
    return '{joiner: $joinerMessage, organizer: $organizerMessage, time: $time}';
  }
}
