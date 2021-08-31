import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shop_app/models/boarding_model.dart';
import 'package:shop_app/modules/auth/login/login_screen.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboarding/onboarding1.png',
      title: 'Screen Title1',
      body: 'Screen body1',
    ),
    BoardingModel(
      image: 'assets/images/onboarding/onboarding2.png',
      title: 'Screen Title2',
      body: 'Screen body2',
    ),
    BoardingModel(
      image: 'assets/images/onboarding/onboarding3.png',
      title: 'Screen Title3',
      body: 'Screen body3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: KBackgroungColor,
          actions: [
            TextButton(
              onPressed: () {
                Get.offAndToNamed(
                  LoginScreen.routName,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only( right: 20.0),
                child: Text(
                  'Skip',
                  style: TextStyle(color: KPrimaryColor),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardingController,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      if (index == boarding.length - 1) {
                        isLast = true;
                      } else {
                        isLast = false;
                      }
                    });
                  },
                  itemBuilder: (context, index) => BuildBordingItem(
                    boardingModel: boarding[index],
                  ),
                  itemCount: boarding.length,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardingController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(activeDotColor: KPrimaryColor),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        Get.offAndToNamed(LoginScreen.routName);
                      } else {
                        boardingController.nextPage(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class BuildBordingItem extends StatelessWidget {
  const BuildBordingItem({
    Key? key,
    required this.boardingModel,
  }) : super(key: key);
  final BoardingModel boardingModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(boardingModel.image),
            fit: BoxFit.fill,
            width: double.infinity,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          boardingModel.title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          boardingModel.body,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
