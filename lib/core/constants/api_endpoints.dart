class ApiEndpoints {
  static String baseUrl = "https://rgukt-hms.vercel.app/api/v1";

  static String signUpEndpoint = "$baseUrl/auth/register";
  static String refreshAccesstoken = "$baseUrl/auth/get-access-token";
}
