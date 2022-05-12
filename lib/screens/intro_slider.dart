// ignore_for_file: prefer_const_constructors
import 'package:app/screens/webview_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroSlider extends StatefulWidget {
  const IntroSlider({Key? key}) : super(key: key);

  @override
  State<IntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      top: false,
      child: Column(
        children: [
          Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  onPageChanged: ((index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  height: _height * 0.9,
                  autoPlay: false,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: false,
                  padEnds: true,
                ),
                items: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/1.jpeg',
                        fit: BoxFit.fill,
                      ),
                      SizedBox(height: _height * 0.06),
                      Padding(
                        padding: EdgeInsets.only(
                            left: _width * 0.07, right: _width * 0.07),
                        child: Text('Welcome to RobotBulls',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: _height * 0.03),
                      Padding(
                        padding: EdgeInsets.only(
                            left: _width * 0.07, right: _width * 0.07),
                        child: Center(
                          child: Text(
                            "We develop trading robots that research for you on the basis of past market experiences and of traders' current emotions.",
                            softWrap: true,
                            style: TextStyle(
                                color: Color.fromARGB(221, 1, 1, 1),
                                fontSize: 21,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/two.jpeg',
                        fit: BoxFit.fill,
                      ),
                      SizedBox(height: _height * 0.06),
                      Padding(
                        padding: EdgeInsets.only(
                            left: _width * 0.07, right: _width * 0.07),
                        child: Text('Invest with ease',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: _height * 0.03),
                      Padding(
                        padding: EdgeInsets.only(
                            left: _width * 0.05, right: _width * 0.05),
                        child: Text(
                          "Choose your trading bot and invest your favourite asset.",
                          softWrap: true,
                          style: TextStyle(
                              color: Color.fromARGB(221, 1, 1, 1),
                              fontSize: 21,
                              fontWeight: FontWeight.w200),
                        ),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/three.jpeg',
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: _height * 0.06),
                        Padding(
                          padding: EdgeInsets.only(
                              left: _width * 0.07, right: _width * 0.07),
                          child: Text(
                              'Unsure about your investment? Try the Demo',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: _height * 0.03),
                        Padding(
                          padding: EdgeInsets.only(
                              left: _width * 0.05, right: _width * 0.05),
                          child: Text(
                            "We offer users the possibility to invest in all of our trading bots with fake money in order to see over some days/weeks/months how the investment evolves",
                            softWrap: true,
                            style: TextStyle(
                                color: Color.fromARGB(221, 1, 1, 1),
                                fontSize: 21,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(_width * 0.45, _height * 0.425, 0, 0),
                child: buildIndicator(),
              )
            ],
          ),
          Center(
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                height: _height * 0.06,
                width: _width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue),
                child: Text('Get Started',
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: _current,
        count: 3,
        effect: SlideEffect(
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: Colors.white,
            dotColor: Colors.grey),
      );
}


// ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: OutlinedButton(
//             style: OutlinedButton.styleFrom(
//                 fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
//                     MediaQuery.of(context).size.height * 0.06),
//                 backgroundColor: Colors.blue),
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const WebviewScreen()),
//               );
//             },
//             child: Text('Get Started',
//                 style: GoogleFonts.roboto(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white)),
//           ),
//         ),