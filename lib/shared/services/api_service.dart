import 'dart:convert';
import 'dart:io';
import 'package:chat_gpt/model/Chat/chat_model.dart';
import 'package:http/http.dart' as http;

String BASE_URL = "https://api.openai.com/v1";
String API_KEY = "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";
void setApiKey(String apiKey) {
  API_KEY = apiKey;
}

class ApiService {
  static String modelName = 'gpt-3.5-turbo';
  static int maxTokens = 100;
  static int addedContext = 2;

  //The system message helps set the behavior of the bot.
  static String systemMsg =
      'You are Jarvis, a friendly chat bot with a bit of sense of humor who gives short and to the point answers.';

  //validate if the text input isn't containing any harmful text
  static Future<bool> validateMessage({required String msg}) async {
    try {
      Uri uri = Uri.parse('$BASE_URL/moderations');
      var response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $API_KEY',
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
      // print('error $error');
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
      Uri uri = Uri.parse('$BASE_URL/chat/completions');
      var response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $API_KEY',
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
      // print('error $error');
      rethrow;
    }
  }
}
