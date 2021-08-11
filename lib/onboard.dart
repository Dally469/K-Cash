import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcash/home.dart';
import 'package:kcash/utils/colors.dart';
import 'package:provider/provider.dart';


class OnBoardScreen extends StatelessWidget {

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider<OnBoardState>(
      create: (_) => OnBoardState(),
      child: Scaffold(
        body: OnBoard(
          pageController: _pageController,
          // Either Provide onSkip Callback or skipButton Widget to handle skip state
          onSkip: () {
            // print('skipped');
          },
          // Either Provide onDone Callback or nextButton Widget to handle done state
          onDone: () {
            // print('done tapped');
          },
          onBoardData: onBoardData,
          titleStyles: GoogleFonts.nunito(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: greenColor
          ),
          descriptionStyles: TextStyle(
            fontSize: 16,
            color: Colors.brown.shade300,
          ),
          pageIndicatorStyle: const PageIndicatorStyle(
            width: 100,
            inactiveColor: primaryColor,
            activeColor: primaryDarkColor,
            inactiveSize: Size(8, 8),
            activeSize: Size(15, 15),
          ),
          // Either Provide onSkip Callback or skipButton Widget to handle skip state
          skipButton: TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new Home()));
            },
            child: const Text(
              "Skip",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: greenColor),
            ),
          ),
          // Either Provide onDone Callback or nextButton Widget to handle done state
          nextButton: Consumer<OnBoardState>(
            builder: (BuildContext context, OnBoardState state, Widget? child) {
              return InkWell(
                onTap: () => _onNextTap(state),
                child: Container(
                  width: 230,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [primaryDarkColor, greenColor],
                    ),
                  ),
                  child: Text(
                    state.isLastPage ? "Done" : "Next",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      print("nextButton pressed");
    }
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Personal Account",
    description: "Goal support your motivation and inspire you to work harder",
    imgUrl: "assets/images/wallet.png",
  ),
  const OnBoardModel(
    title: "Payment",
    description:
    "Analyse personal result with detailed chart and numerical values",
    imgUrl: 'assets/images/other.png',
  ),
  const OnBoardModel(
    title: "Finish",
    description:
    "Take before and after photos to visualize progress and get the shape that you dream about",
    imgUrl: 'assets/images/wallet.png',
  ),
];