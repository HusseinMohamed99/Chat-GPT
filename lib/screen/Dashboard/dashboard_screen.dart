import 'package:chat_gpt/image_assets.dart';
import 'package:chat_gpt/screen/Conversation/conversation_screen.dart';
import 'package:chat_gpt/shared/components/chat_widget.dart';
import 'package:chat_gpt/shared/components/my_divider.dart';
import 'package:chat_gpt/shared/components/navigator.dart';
import 'package:chat_gpt/shared/providers/chats_provider.dart';
import 'package:chat_gpt/shared/style/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(),
      child: Scaffold(
        backgroundColor: AppMainColors.darkColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 10,
          backgroundColor: AppMainColors.darkColor,
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                navigateTo(context, const ConversationScreen());
              },
              child: Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                height: 52.h,
                width: 335.w,
                decoration: BoxDecoration(
                    color: AppMainColors.darkColor,
                    borderRadius: BorderRadius.circular(1)),
                child: Row(
                  children: [
                    const ImageIcon(
                      color: AppMainColors.whiteColor,
                      AssetImage(Assets.imagesMessage),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      'New Chat',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    const ImageIcon(
                      color: AppMainColors.whiteColor,
                      AssetImage(Assets.imagesArrowForward2),
                    ),
                  ],
                ),
              ),
            ),
            const MyDivider(horizontal: 20),
            if (chatProvider.getChatList.isNotEmpty)
              GestureDetector(
                onTap: () {
                  navigateTo(context, const ConversationScreen());
                },
                child: Container(
                  margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                  height: 52.h,
                  width: 335.w,
                  decoration: BoxDecoration(
                      color: AppMainColors.darkColor,
                      borderRadius: BorderRadius.circular(1)),
                  child: Row(
                    children: [
                      const ImageIcon(
                        color: AppMainColors.whiteColor,
                        AssetImage(Assets.imagesMessage),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: chatProvider
                                .getChatList.length, //chatList.length,
                            itemBuilder: (context, index) {
                              if (chatProvider.getChatList[index].chatIndex ==
                                  0) {
                                return DashboardChatList(
                                  msg: chatProvider.getChatList[index].msg,
                                  // chatList[index].msg,
                                  chatIndex: chatProvider.getChatList[index]
                                      .chatIndex, //chatList[index].chatIndex,);
                                  shouldAnimate:
                                      chatProvider.getChatList.length - 1 ==
                                          index,
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                      ),
                      const ImageIcon(
                        color: AppMainColors.whiteColor,
                        AssetImage(Assets.imagesArrowForward2),
                      ),
                    ],
                  ),
                ),
              ),
            const MyDivider(horizontal: 20),
            const Spacer(),
            const MyDivider(),
            Container(
              height: 316.h,
              width: 375.w,
              margin: const EdgeInsetsDirectional.symmetric(
                horizontal: 12,
              ),
              decoration: const BoxDecoration(
                color: AppMainColors.darkColor,
              ),
              child: Column(
                children: [
                  ListOfOptions(
                    imageIcon: Assets.imagesDelete,
                    text: 'Clear conversations',
                    function: () {
                      if (kDebugMode) {
                        print('conversations');
                      }
                    },
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: ListOfOptions(
                          function: () {
                            if (kDebugMode) {
                              print('Upgrade');
                            }
                          },
                          imageIcon: Assets.imagesUser,
                          text: 'Upgrade to Plus',
                        ),
                      ),
                      Container(
                        width: 46.w,
                        height: 20.h,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0.50),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFAF3AD),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'NEW',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.h),
                  ListOfOptions(
                    function: () {
                      if (kDebugMode) {
                        print('mode');
                      }
                    },
                    imageIcon: Assets.imagesSun,
                    text: 'Light mode',
                  ),
                  SizedBox(height: 8.h),
                  ListOfOptions(
                    function: () {
                      if (kDebugMode) {
                        print('Updates');
                      }
                    },
                    imageIcon: Assets.imagesUpdates,
                    text: 'Updates & FAQ',
                  ),
                  SizedBox(height: 8.h),
                  ListOfOptions(
                    function: () {
                      if (kDebugMode) {
                        print('Logout');
                      }
                    },
                    imageIcon: Assets.imagesLogout,
                    text: 'Logout',
                    textColor: AppMainColors.redColor,
                    iconColor: AppMainColors.redColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListOfOptions extends StatelessWidget {
  const ListOfOptions({
    super.key,
    required this.imageIcon,
    required this.text,
    this.iconColor,
    this.textColor,
    required this.function,
  });
  final String imageIcon;
  final String text;
  final Color? iconColor;
  final Color? textColor;
  final void Function()? function;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function!();
      },
      child: Container(
        width: 335.w,
        height: 52.h,
        alignment: Alignment.center,
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: Row(
          children: [
            ImageIcon(
              color: iconColor ?? AppMainColors.whiteColor,
              AssetImage(imageIcon),
            ),
            SizedBox(width: 16.w),
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: textColor ?? AppMainColors.whiteColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
