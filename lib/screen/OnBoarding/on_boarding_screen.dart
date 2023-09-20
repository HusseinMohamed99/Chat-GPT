import 'package:chat_gpt/image_assets.dart';
import 'package:chat_gpt/model/OnBoarding/on_boarding.dart';
import 'package:chat_gpt/shared/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();
  List<OnBoardingModel> onBoarding = [
    OnBoardingModel(
      image: Assets.imagesVector1,
      title: '“Explain quantum computing in simple terms”',
      text: "“Got any creative ideas for a 10 year old's birthday?”",
      body: '“How do I make an HTTP request in Javascript?”',
    ),
    OnBoardingModel(
      image: Assets.imagesFrame,
      title: 'Remembers what user said earlier in the conversation',
      text: 'Allows user to provide follow-up corrections',
      body: 'Trained to decline inappropriate requests',
    ),
    OnBoardingModel(
      image: Assets.imagesGroup,
      title: 'May occasionally generate incorrect information',
      text: 'May occasionally produce harmful instructions or biased content',
      body: 'Limited knowledge of world and events after 2021',
    ),
  ];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppMainColors.secondColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppMainColors.secondColor,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Center(
            child: SvgPicture.asset(
              Assets.imagesLogo,
              width: 24,
              fit: BoxFit.fitHeight,
              height: 24.h,
              placeholderBuilder: (_) => Shimmer.fromColors(
                baseColor: Colors.grey[850]!,
                highlightColor: Colors.grey[800]!,
                child: Container(
                  height: 350.h,
                  color: AppMainColors.greyColor,
                ),
              ),
            ),
          ),
          Text(
            'Welcome to\n ChatGPT',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 14.h),
          Text(
            'Ask anything, get your answer',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ]),
      ),
    );
  }
}

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({super.key, required this.onBoardingModel});

  final OnBoardingModel onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SvgPicture.asset(
        onBoardingModel.image,
        width: 24,
        fit: BoxFit.fitHeight,
        height: 24.h,
        placeholderBuilder: (_) => Shimmer.fromColors(
          baseColor: Colors.grey[850]!,
          highlightColor: Colors.grey[800]!,
          child: Container(
            height: 350.h,
            color: AppMainColors.greyColor,
          ),
        ),
      ),
      Expanded(
        child: SizedBox(
          width: 312.w,
          height: 64.h,
          // margin: EdgeInsetsDirectional.symmetric(horizontal: D.sizeXLarge.w),
          child: Text(
            onBoardingModel.body,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    ]);
  }
}
