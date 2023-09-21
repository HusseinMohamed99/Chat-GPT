import 'dart:developer';
import 'package:chat_gpt/image_assets.dart';
import 'package:chat_gpt/shared/components/chat_widget.dart';
import 'package:chat_gpt/shared/components/my_divider.dart';
import 'package:chat_gpt/shared/components/navigator.dart';
import 'package:chat_gpt/shared/components/text_form_field.dart';
import 'package:chat_gpt/shared/components/text_widget.dart';
import 'package:chat_gpt/shared/providers/chats_provider.dart';
import 'package:chat_gpt/shared/providers/models_provider.dart';
import 'package:chat_gpt/shared/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  bool _isTyping = false;
  late ScrollController _listScrollController;
  late TextEditingController textController = TextEditingController();
  late FocusNode focusNode;

  @override
  void initState() {
    _listScrollController = ScrollController();
    textController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 335.w,
          leading: Container(
            width: 335,
            height: 64,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsetsDirectional.zero,
                      icon: const ImageIcon(AssetImage(Assets.imagesArrowBack)),
                      onPressed: () {
                        pop(context);
                      },
                    ),
                    Text(
                      'Back',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(Assets.imagesLogo),
                  ],
                ),
                const MyDivider(),
              ],
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: chatProvider.chatList.isEmpty
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                const Spacer(),
                chatProvider.chatList.isEmpty
                    ? Text(
                        'Ask anything, get your answer',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppMainColors.whiteColor
                                      .withOpacity(0.4000000059604645),
                                ),
                      )
                    : Flexible(
                        child: ListView.builder(
                            controller: _listScrollController,
                            itemCount: chatProvider
                                .getChatList.length, //chatList.length,
                            itemBuilder: (context, index) {
                              return ChatWidget(
                                msg: chatProvider.getChatList[index]
                                    .msg, // chatList[index].msg,
                                chatIndex: chatProvider.getChatList[index]
                                    .chatIndex, //chatList[index].chatIndex,
                                shouldAnimate:
                                    chatProvider.getChatList.length - 1 ==
                                        index,
                              );
                            }),
                      ),
                if (_isTyping) ...[
                  const SpinKitThreeBounce(
                    color: Colors.white,
                    size: 18,
                  ),
                ],
                const SizedBox(
                  height: 15,
                ),
                const Spacer(),
                DefaultTextFormField(
                  controller: textController,
                  keyboardType: TextInputType.text,
                  suffixPressed: () async {
                    await sendMessageFCT(
                        modelsProvider: modelsProvider,
                        chatProvider: chatProvider);
                  },
                  validate: (String? value) {
                    if (value!.trim().isEmpty) {
                      return "Please type a message";
                    }
                    return null;
                  },
                  hint: '',
                  suffix: const AssetImage(Assets.imagesSend),
                ),
              ]),
        ),
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatProvider}) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "You cant send multiple messages at a time",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Please type a message",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String msg = textController.text;
      setState(() {
        _isTyping = true;
        chatProvider.addUserMessage(msg: msg);
        textController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(
          msg: msg, chosenModelId: modelsProvider.getCurrentModel);
      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextWidget(
          label: error.toString(),
        ),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
