import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_gpt/shared/components/text_widget.dart';
import 'package:chat_gpt/shared/style/color.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  ChatWidget(
      {super.key,
      required this.msg,
      required this.chatIndex,
      required this.isLast});

  final String msg;
  final int chatIndex;
  final bool isLast;
  bool isShown = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0
              ? AppMainColors.primaryColor
              : AppMainColors.greyColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: chatIndex != 0 // is from user
                      ? chatIndex == 1 // is not harmful
                          ? TextWidget(
                              label: msg,
                            )
                          : TextWidget(
                              label: msg,
                              textColor: Colors.red,
                            )
                      : isLast
                          ? StatefulBuilder(builder: ((context, setState) {
                              return isShown
                                  ? Text(
                                      msg.trim(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    )
                                  : DefaultTextStyle(
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                      child: AnimatedTextKit(
                                        onFinished: () {
                                          // _animationCount = 0;
                                          setState(
                                            () {
                                              isShown = true;
                                            },
                                          );
                                        },
                                        isRepeatingAnimation: false,
                                        repeatForever: false,
                                        displayFullTextOnTap: true,
                                        totalRepeatCount: 1,
                                        animatedTexts: [
                                          TyperAnimatedText(
                                            msg.trim(),
                                          ),
                                        ],
                                      ),
                                    );
                            }))
                          : Text(
                              msg.trim(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
