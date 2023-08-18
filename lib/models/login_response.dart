class LoginResponse {
  late String accessToken;
  late String refreshToken;
  late String accessUuid;
  late String refreshUuid;
  late int atExpires;
  late int rtExpires;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.accessUuid,
    required this.refreshUuid,
    required this.atExpires,
    required this.rtExpires,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['AccessToken'] ?? '';
    refreshToken = json['RefreshToken'] ?? '';
    accessUuid = json['AccessUuid'] ?? '';
    refreshUuid = json['RefreshUuid'] ?? '';
    atExpires = json['AtExpires'] ?? 0;
    rtExpires = json['RtExpires'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'AccessToken': accessToken,
      'RefreshToken': refreshToken,
      'AccessUuid': accessUuid,
      'RefreshUuid': refreshUuid,
      'AtExpires': atExpires,
      'RtExpires': rtExpires,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
