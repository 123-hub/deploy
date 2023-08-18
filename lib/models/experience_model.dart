import 'package:intl/intl.dart';

class ExperienceModel {
  ExperienceModel({
    required this.position,
    required this.companyName,
    required this.description,
    required this.from,
    required this.to,
  });
  late final String position;
  late final String companyName;
  late final String description;
  late final String from;
  late final String to;
  
  ExperienceModel.fromJson(Map<String, dynamic> json){
    position = json['position'];
    companyName = json['company_name'];
    description = json['description'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['position'] = position;
    data['company_name'] = companyName;
    data['description'] = description;
    data['from'] = '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.parse(from))}Z';
    data['to'] = '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.parse(to))}Z';
    return data;
  }
}