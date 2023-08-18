import 'package:intl/intl.dart';

class LicenseModel {
  LicenseModel({
    required this.licenseName,
    required this.description,
    required this.from,
    required this.to,
    required this.expiryDate,
  });
  late final String licenseName;
  late final String description;
  late final String from;
  late final String to;
  late final String expiryDate;
  
  LicenseModel.fromJson(Map<String, dynamic> json){
    licenseName = json['license_name'];
    description = json['description'];
    from = json['from'];
    to = json['to'];
    expiryDate = json['expiry_date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['license_name'] = licenseName;
    data['description'] = description;
    data['from'] = '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.parse(from))}Z';
    data['to'] = '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.parse(to))}Z';
    data['expiry_date'] = '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.parse(expiryDate))}Z';
    return data;
  }
}