class RoomMessage {
  RoomMessage({
    required this.id,
    required this.roomId,
    required this.labourMessage,
    required this.contractorMessage,
    required this.createdAt,
  });
  late final int id;
  late final int roomId;
  late final String labourMessage;
  late final String contractorMessage;
  late final String createdAt;
  
  RoomMessage.fromJson(Map<String, dynamic> json){
    id = json['id'];
    roomId = json['room_id'];
    labourMessage = json['labour_message'];
    contractorMessage = json['contractor_message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['room_id'] = roomId;
    data['labour_message'] = labourMessage;
    data['contractor_message'] = contractorMessage;
    data['created_at'] = createdAt;
    return data;
  }
}