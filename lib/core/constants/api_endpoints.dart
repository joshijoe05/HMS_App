class ApiEndpoints {
  static String baseUrl = "https://rgukt-hms.vercel.app/api/v1";

  static String signUpEndpoint = "$baseUrl/auth/register";
  static String loginEndpoint = "$baseUrl/auth/login";
  static String refreshAccesstoken = "$baseUrl/auth/get-access-token";
  static String profile = "$baseUrl/auth/profile";

  static String getHostelsEndpoint = "$baseUrl/hostel/";
  static String getYourComplaints = "$baseUrl/complaints/";
  static String raiseComplaint = "$baseUrl/complaints/create";
  static String getComplaintDetails = "$baseUrl/complaints/";
  static String addComment = "$baseUrl/complaints/comment/";
}
