import 'package:intl/intl.dart';

class Room {
  Room({
    required this.id,
    required this.joinerId,
    required this.joinerType,
    required this.organizerId,
    required this.joinerName,
    required this.organizerName,
    required this.createdAt,
  });
  late final int id;
  late final int joinerId;
  late final String joinerType;
  late final int organizerId;
  late final String joinerName;
  late final String organizerName;
  late final DateTime createdAt;
  
  Room.fromJson(Map<String, dynamic> json){
    id = json['id'];
    joinerId = json['joiner_id'];
    joinerType = json['joiner_type'];
    organizerId = json['organizer_id'];
    joinerName = json['joiner_name'];
    organizerName = json['organizer_name'];
    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['joiner_id'] = joinerId;
    data['joiner_type'] = joinerType;
    data['organizer_id'] = organizerId;
    data['joiner_name'] = joinerName;
    data['organizer_name'] = organizerName;
    data['created_at'] = '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(createdAt)}Z';
    return data;
  }
}