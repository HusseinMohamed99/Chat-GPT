import 'dart:async';
import 'package:chat_gpt/model/Chat/chat_model.dart';
import 'package:chat_gpt/shared/services/api_service.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];

  int addedContext = ApiService.addedContext;

  List<ChatModel> get getChatList {
    return chatList;
  }

  void timerToRemove() {
    Timer timer = Timer(const Duration(seconds: 1), (() {
      chatList.removeWhere((element) => element.chatIndex == -1);
      notifyListeners();
    }));
  }

  void addHarmfulMessage({required String msg}) {
    chatList.removeLast();

    chatList.add(
      ChatModel(
        chatIndex: -1,
        msg: msg,
      ),
    );

    timerToRemove();

    notifyListeners();
  }

  void addUserMessage({required String msg}) {
    chatList.add(
      ChatModel(
        chatIndex: 1,
        msg: msg,
      ),
    );
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers({
    required String msg,
    required String modelId,
    required double temperature,
  }) async {
    List<Map<String, String>> messages = [];

    if (chatList.length - 2 * addedContext - 1 < 0) {
      for (int i = 0; i < chatList.length; i++) {
        if (i % 2 == 0) {
          messages.add({'role': 'user', 'content': chatList[i].msg});
        } else {
          messages.add({'role': 'assistant', 'content': chatList[i].msg});
        }
      }
    } else {
      for (int i = chatList.length - 2 * addedContext - 1;
          i < chatList.length;
          i++) {
        if (i % 2 == 0) {
          messages.add({'role': 'user', 'content': chatList[i].msg});
        } else {
          messages.add({'role': 'assistant', 'content': chatList[i].msg});
        }
      }
    }

    chatList.addAll(
      await ApiService.sendChatMessage(
        modelId: modelId,
        temperature: temperature,
        messageBody: messages,
      ),
    );

    notifyListeners();
  }
}
