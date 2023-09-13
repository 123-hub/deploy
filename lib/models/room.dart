class Room {
  Room({
    required this.id,
    required this.labourId,
    required this.contractorId,
    required this.createdAt,
  });
  late final int id;
  late final int labourId;
  late final int contractorId;
  late final String createdAt;
  
  Room.fromJson(Map<String, dynamic> json){
    id = json['id'];
    labourId = json['labour_id'];
    contractorId = json['contractor_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['labour_id'] = labourId;
    data['contractor_id'] = contractorId;
    data['created_at'] = createdAt;
    return data;
  }
}