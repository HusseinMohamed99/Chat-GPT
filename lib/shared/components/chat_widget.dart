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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: chatIndex == 1
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 267,
                    height: 43,
                    padding: const EdgeInsets.all(12),
                    decoration: const ShapeDecoration(
                      color: Color(0xFF10A37F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        chatIndex == 1 // is not harmful
                            ? TextWidget(
                                label: msg,
                              )
                            : TextWidget(
                                label: msg,
                                textColor: Colors.red,
                              )
                      ],
                    ),
                  ),
                )
              : Expanded(child: StatefulBuilder(builder: ((context, setState) {
                  return isShown
                      ? Container(
                          padding: const EdgeInsets.all(12),
                          decoration: ShapeDecoration(
                            color:
                                Colors.white.withOpacity(0.20000000298023224),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                          ),
                          child: Text(
                            msg.trim(),
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : DefaultTextStyle(
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: ShapeDecoration(
                              color:
                                  Colors.white.withOpacity(0.20000000298023224),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
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
                          ),
                        );
                }))),
        )
      ],
    );
  }
}
