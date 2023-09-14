import 'package:intl/intl.dart';

class Room {
  Room({
    required this.id,
    required this.labourId,
    required this.contractorId,
    required this.labourName,
    required this.contractorName,
    required this.createdAt,
  });
  late final int id;
  late final int labourId;
  late final int contractorId;
  late final String labourName;
  late final String contractorName;
  late final DateTime createdAt;
  
  Room.fromJson(Map<String, dynamic> json){
    id = json['id'];
    labourId = json['labour_id'];
    contractorId = json['contractor_id'];
    labourName = json['labour_name'];
    contractorName = json['contractor_name'];
    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['labour_id'] = labourId;
    data['contractor_id'] = contractorId;
    data['labour_name'] = labourName;
    data['contractor_name'] = contractorName;
    data['created_at'] = '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(createdAt)}Z';
    return data;
  }
}