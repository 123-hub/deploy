class Endpoints {
  static const Map<String, String> jsonHeader = {
    'Content-Type': 'application/json'
  };
  static const String baseUrl = 'https://civil.orgosys.com/v1';
  static const String labourUrl = '$baseUrl/labour';
  static const String contractorUrl = '$baseUrl/contractor';
  static const String labourLogin = '$labourUrl/login';
  static const String contractorLogin = '$contractorUrl/login';
  static const String labourOTP = '$labourUrl/send-otp/labour';
  static const String contractorOTP = '$contractorUrl/send-otp/contractor';
  static const String varifyLabourOTP = '$labourUrl/verify-otp/labour';
  static const String varifyContractorOTP = '$contractorUrl/verify-otp/contractor';
  static const String labourSignup = '$labourUrl/sign-up';
  static const String contractorSignup = '$contractorUrl/sign-up';
}
