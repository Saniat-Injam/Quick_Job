import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  static const String baseUrl = "https://your-backend-url.com/api";
  static const String apiKey = "YOUR_BACKEND_API_KEY";

  static Future<void> updateNotificationStatus(bool enabled) async {
    final url = Uri.parse("$baseUrl/update-notification");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: jsonEncode({"notifications_enabled": enabled}),
    );

    print("Backend Notification Update → ${response.body}");
  }
}
