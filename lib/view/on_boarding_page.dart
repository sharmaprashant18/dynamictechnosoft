import 'dart:async';

import 'package:dynamictechnosoft/model/onboarding_model.dart';
import 'package:dynamictechnosoft/view/home_page.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController pageController = PageController();
  int currentIndex = 0;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    autoAdvance();
  }

  @override
  void dispose() {
    timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  void autoAdvance() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 3), (timers) {
      if (currentIndex < pagesData.length - 1) {
        pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else {
        timer?.cancel();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 10,
            right: 0,
            child: Column(
              children: [
                // Page indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pagesData.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == index
                              ? Colors.black
                              : Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
                // resetTimer();
                autoAdvance();
              },
              itemCount: pagesData.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(pagesData[index].image),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Text(
                        pagesData[index].title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(pagesData[index].description)
                    ],
                  ),
                );
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentIndex < pagesData.length - 1) ...[
                    ElevatedButton(
                        onPressed: () {
                          timer?.cancel();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));
                        },
                        child: Text('Skip')),
                    Center(
                      child: ElevatedButton(
                        //
                        onPressed: () {
                          autoAdvance();
                          pageController.nextPage(
                            duration: const Duration(microseconds: 100),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text('Next'),
                      ),
                    ),
                  ] else
                    Padding(
                      padding: const EdgeInsets.only(left: 150),
                      child: ElevatedButton(
                        onPressed: () {
                          timer?.cancel();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                        child: Text('Get Started'),
                      ),
                    ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
