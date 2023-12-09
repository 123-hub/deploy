class Endpoints {
  static const Map<String, String> jsonHeader = {
    'Content-Type': 'application/json'
  };
  static const String domain = 'civil.orgosys.com';
  static const String baseUrl = 'https://$domain/v1';
  static const String labourUrl = '$baseUrl/labour';
  static const String contractorUrl = '$baseUrl/contractor';
  static const String labourLogin = '$labourUrl/login';
  static const String contractorLogin = '$contractorUrl/login';
  static const String labourOTP = '$labourUrl/send-otp/labour';
  static const String contractorOTP = '$contractorUrl/send-otp/contractor';
  static const String varifyLabourOTP = '$labourUrl/verify-otp/labour';
  static const String varifyContractorOTP =
      '$contractorUrl/verify-otp/contractor';
  static const String labourSignup = '$labourUrl/sign-up';
  static const String contractorSignup = '$contractorUrl/sign-up';
  static const String labourProfile = '$labourUrl/profile';
  static const String contractorProfile = '$contractorUrl/profile';
  static const String labourJob = '$labourUrl/jobs';
  static const String labourApplyJobs = '$labourUrl/apply-job';
  static const String labourSaveJob = '$labourUrl/save-job';
  static const String deleteLabourProfileDoc = '$labourUrl/delete/profile-doc';
  static const String contractorJob = '$contractorUrl/job';
  static const String contractorAllJobs = '$contractorUrl/jobs';
  static const String contractorBidding = '$contractorUrl/bidding';
  static const String deleteContractorProfileDoc = '$contractorUrl/delete/profile-doc';

  static const String contractorJobApplicants =
      '$contractorUrl/job-application';
  static const String contractorhired = '$contractorUrl/hire';
  static const String labourChat = '$labourUrl/chat';
  static const String labourGetRooms = '$labourChat/room';
  static const String labourGetMessages = '$labourChat/message';
  static const String labourChatStream =
      'wss://civil.orgosys.com/v1/ws/labour/chat';
  static const String contractorChat = '$contractorUrl/chat';
  static const String contractorGetRooms = '$contractorChat/room';
  static const String contractorGetMessages = '$contractorChat/message';
  static const String contractorChatStream =
      'wss://civil.orgosys.com/v1/ws/contractor/chat';
}
