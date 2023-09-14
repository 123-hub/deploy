class MessageContent {
  late String labourMessage;
  late String contractorMessage;
  late DateTime time;

  MessageContent.fromJson(json) {
    labourMessage = json['labour_message'];
    contractorMessage = json['contractor_message'];
    time = DateTime.parse(json['created_at']);
  }

  MessageContent({
    required this.labourMessage,
    required this.contractorMessage,
    required this.time,
  });

  @override
  String toString() {
    return '{labour: $labourMessage, contractor: $contractorMessage, time: $time}';
  }
}
