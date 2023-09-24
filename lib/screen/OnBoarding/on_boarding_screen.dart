import 'package:chat_gpt/image_assets.dart';
import 'package:chat_gpt/model/OnBoarding/on_boarding.dart';
import 'package:chat_gpt/screen/Dashboard/dashboard_screen.dart';
import 'package:chat_gpt/shared/components/navigator.dart';
import 'package:chat_gpt/shared/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();
  List<OnBoardingModel> onBoarding = [
    OnBoardingModel(
      image: Assets.imagesFrame,
      title: 'Examples',
      body: '“Explain quantum computing in\n simple terms”',
      label: "“Got any creative ideas for a 10\n year old's birthday?”",
      text: '“How do I make an HTTP request\n in Javascript?”',
    ),
    OnBoardingModel(
      image: Assets.imagesVector1,
      title: 'Capabilities',
      body: 'Remembers what user said earlier\n in the conversation',
      label: 'Allows user to provide follow-up\n corrections',
      text: 'Trained to decline inappropriate\n requests',
    ),
    OnBoardingModel(
      image: Assets.imagesGroup,
      title: 'Limitations',
      body: 'May occasionally generate\n incorrect information',
      label:
          'May occasionally produce harmful\n instructions or biased content',
      text: 'Limited knowledge of world and\n events after 2021',
    ),
  ];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 10,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
            SizedBox(height: 24.h),
            Text(
              'Welcome to\n ChatGPT',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 24.h),
            Text(
              'Ask anything, get your answer',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 60.h),
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == onBoarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: pageController,
                itemBuilder: (context, index) => OnBoardingItem(
                  onBoardingModel: onBoarding[index],
                ),
                itemCount: onBoarding.length,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: onBoarding.length,
                  effect: WormEffect(
                    dotWidth: 28.w,
                    dotHeight: 2.h,
                    dotColor: AppMainColors.whiteColor.withOpacity(0.2),
                    activeDotColor: AppMainColors.primaryColor,
                    spacing: 12,
                    radius: 12,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                if (isLast) {
                  navigateAndFinish(context, const DashboardScreen());
                } else {
                  pageController.nextPage(
                    duration: const Duration(
                      milliseconds: 780,
                    ),
                    curve: Curves.ease,
                  );
                }
              },
              child: Container(
                margin: const EdgeInsetsDirectional.only(
                  start: 20,
                  end: 20,
                  bottom: 20,
                ),
                height: 48.h,
                width: 335.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppMainColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isLast
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Let's Chat",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(width: 12),
                          SvgPicture.asset(
                            Assets.imagesArrowForward,
                            width: 10.w,
                            height: 12.h,
                          ),
                        ],
                      )
                    : Text(
                        'Next',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({super.key, required this.onBoardingModel});

  final OnBoardingModel onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
        SizedBox(height: 12.h),
        Text(
          onBoardingModel.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 40.h),
        ListOfText(onBoardingModel: onBoardingModel.body),
        SizedBox(height: 16.h),
        ListOfText(onBoardingModel: onBoardingModel.label),
        SizedBox(height: 16.h),
        ListOfText(onBoardingModel: onBoardingModel.text),
      ]),
    );
  }
}

class ListOfText extends StatelessWidget {
  const ListOfText({
    super.key,
    required this.onBoardingModel,
  });

  final String onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 62.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xff444550),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 37.5.w,
        vertical: 12.h,
      ),
      child: Text(
        onBoardingModel,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
