import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Text Page'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Center(
                    child: Text(
                  'This is the animated text',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ).animate().custom(
                  builder: (context, value, child) {
                    return Animate(
                      child: Container(
                          child: child
                              .animate(effects: [
                                // BoxShadowEffect(
                                //     duration: Duration(milliseconds: 200),
                                //     curve: Curves.fastEaseInToSlowEaseOut,
                                //     delay: Duration(seconds: 2)),
                                // BlurEffect(
                                //   duration: Duration(seconds: 1),
                                //   delay: Duration(seconds: 2),
                                //   end: Offset(-1,1),
                                //   begin: Offset(2, 2)

                                // ),
                                VisibilityEffect(
                                    delay: Duration(seconds: 2),
                                    curve: Curves.bounceOut),
                                ElevationEffect(
                                  begin: 10,
                                  end: 35,
                                  duration: Duration(
                                      seconds:
                                          2), //this means that how much time it will work
                                  delay: Duration(
                                      seconds:
                                          5), //this delay means after how many time the effect will come

                                  // color: Colors.red
                                ),

                                // ColorEffect(
                                //   curve: Curves.bounceInOut,
                                //   delay: Duration(seconds: 3),
                                //   duration: Duration(seconds: 1),
                                //   begin: Colors.red,
                                //   end: Colors.amber,
                                // ),
                                // AlignEffect(duration: Duration(seconds: 1)),
                              ])
                              .animate()
                              .scaleX(
                                  duration: Duration(seconds: 10),
                                  delay: Duration(milliseconds: 200),
                                  begin: -1,
                                  curve: Curves.easeInOutCubicEmphasized,
                                  end: 1,
                                  transformHitTests: true)
                              .scale(delay: 1.seconds, duration: 2.seconds)
                              .shimmer(
                                  colors: [
                                    Colors.purple,
                                    Colors.red,
                                    Colors.green,
                                    Colors.blue,
                                    Colors.yellow,
                                    Colors.purple,
                                    Colors.tealAccent,
                                    Colors.indigo
                                  ],
                                  curve: Curves.bounceOut,
                                  angle: 2,
                                  delay: Duration(seconds: 1),
                                  duration: Duration(seconds: 10),
                                  size: 10)),
                    );
                  },
                )),
              ),
              Column(
                children: [
                  ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ToggleButtonPage()));
                          },
                          child: Text('Example of toggle button in animate')
                              .animate(
                                autoPlay: true,
                              )
                              .scaleXY()
                              .blurXY(
                                  duration: 2.seconds,
                                  delay: 2.seconds,
                                  begin: 5)
                              .scale(curve: Curves.easeInOutQuad))
                      .animate()
                      .scaleX(delay: 0.5.seconds)
                      .show(delay: 1.seconds, duration: 2.seconds),
                  ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SwappingPage(),
                                ));
                          },
                          child: Text('Example of swapping in animate')
                              .animate(
                                autoPlay: true,
                              )
                              .scaleXY()
                              .blurXY(
                                  duration: 2.seconds,
                                  delay: 3.seconds,
                                  begin: 5)
                              .scale(curve: Curves.easeInOutQuad))
                      .animate()
                      .scaleX(delay: 0.5.seconds)
                      .show(delay: 2.seconds, duration: 2.seconds),
                  ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImagePage(),
                                ));
                          },
                          child: Text('Example of Image in animate')
                              .animate(
                                autoPlay: true,
                              )
                              .scaleXY()
                              .blurXY(
                                  duration: 2.seconds,
                                  delay: 4.seconds,
                                  begin: 5)
                              .scale(curve: Curves.easeInOutQuad))
                      .animate()
                      .scaleX(delay: 0.5.seconds)
                      .show(delay: 3.seconds, duration: 2.seconds),
                  ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AnimateDoPage(),
                                ));
                          },
                          child: Text('Example of Animation')
                              .animate(
                                autoPlay: true,
                              )
                              .scaleXY()
                              .blurXY(
                                  duration: 2.seconds,
                                  delay: 5.seconds,
                                  begin: 5)
                              .scale(curve: Curves.easeInOutQuad))
                      .animate()
                      .scaleX(delay: 0.5.seconds)
                      .show(delay: 4.seconds, duration: 2.seconds),
                ],
              ),
            ],
          ),
        ],
      ).animate().shake(
          delay: Duration(seconds: 1),
          duration: Duration(seconds: 7),
          hz: 0.5,
          curve: Curves.easeInOutCubicEmphasized),
    );
  }
}

class ToggleButtonPage extends StatelessWidget {
  const ToggleButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    double widthChecker(double screenWidth) {
      if (screenWidth < 600) {
        return screenWidth * 0.9;
      } else {
        return screenWidth * 0.2;
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Animate().toggle(
        duration: 1.ms,
        builder: (_, value, __) => Center(
          child: Container(
            // duration: 5.seconds,
            alignment: Alignment.center,
            height: height * 0.05,
            // width: width * 0.5,
            width: widthChecker(width),
            child: Text('Toggle Button'),
            color: value ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }
}

class SwappingPage extends StatelessWidget {
  const SwappingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
          child: Text(
            "Before Swapping",
            style: TextStyle(color: Colors.red, fontSize: 30),
          ).animate().swap(
              duration: 1.seconds,
              builder: (_, __) => Text(
                    "After Swapping",
                    style: TextStyle(color: Colors.amber, fontSize: 30),
                  )),
        ),
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: Center(
          child: Image.asset('assets/loadingpage.png').animate().scaleXY(
              duration: Duration(seconds: 5), curve: Curves.bounceInOut),
        ),
      ),
    );
  }
}

class AnimateDoPage extends StatelessWidget {
  AnimateDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // FlipInY(animate: true, child: Text('FlipInY Example')),
            // FlipInX(animate: true, child: Text('FlipInX Example')),
            // ElasticIn(animate: true, child: Text('ElasticIn Example')),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  
                  children: [
                    FadeIn(animate: true, child: Square().slideDown().moveTo(bottom: 10)),
                    FadeInDown(animate: true, child: Square().moveTo(top: 20).backInRight().bounceIn()),
                    FadeInUp(animate: true, child: Square().moveTo(top: 40).bounceInDown()),
                    FadeInUpBig(animate: true, child: Square().moveTo(top: 60).elasticIn()),
                    FadeInDownBig(animate: true, child: Square().moveTo(top: 80).elasticIn()),
                    FadeInRight(animate: true, child: Square().moveTo(top: 100)),
                 
                    FadeInLeft( animate: true,
                      curve: Curves.bounceIn,
                      child: Square().dance().fadeInDownBig().zoomIn().flash().flipInX().backInLeft(),
                      //  onFinish:(direction) => Navigator.push(context,MaterialPageRoute(builder:(context) => MovieScreen(),)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Square extends StatelessWidget {
  const Square({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.red,
    );
  }
}


