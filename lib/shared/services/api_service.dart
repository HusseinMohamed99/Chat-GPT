import 'dart:convert';
import 'dart:io';
import 'package:chat_gpt/model/Chat/chat_model.dart';
import 'package:http/http.dart' as http;

String baseUrl = "https://api.openai.com/v1";
String apiKey = "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";
void setApiKey(String key) {
  apiKey = key;
}

class ApiService {
  static String modelName = 'gpt-3.5-turbo';
  static int maxTokens = 100;
  static int addedContext = 2;

  static Future<bool> validateMessage({required String msg}) async {
    try {
      Uri uri = Uri.parse('$baseUrl/moderations');
      var response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'input': msg}),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      bool isHarmful = false;

      if (jsonResponse['results'].length > 0) {
        isHarmful = jsonResponse['results'][0]['flagged'];
      }

      return isHarmful;
    } catch (error) {
      rethrow;
    }
  }

  // Send Message using ChatGPT API
  static Future<List<ChatModel>> sendChatMessage({
    required String modelId,
    required double temperature,
    required List<Map<String, String>> messageBody,
  }) async {
    try {
      Uri uri = Uri.parse('$baseUrl/chat/completions');
      var response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": modelName,
          "messages": messageBody,
          "temperature": temperature,
          "max_tokens": maxTokens
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];

      if (jsonResponse['choices'].length > 0) {
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) => ChatModel(
            msg: jsonResponse['choices'][index]['message']['content'],
            chatIndex: 0,
          ),
        );
      }

      return chatList;
    } catch (error) {
      rethrow;
    }
  }
}
