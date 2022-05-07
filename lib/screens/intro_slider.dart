// ignore_for_file: prefer_const_constructors
import 'package:app/screens/webview_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class IntroSlider extends StatelessWidget {
  const IntroSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CarouselSlider(
          options: CarouselOptions(
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
                SizedBox(height: _height * 0.15),
                Padding(
                  padding: EdgeInsets.only(
                      left: _width * 0.05, right: _width * 0.05),
                  child: Text('Welcome to RobotBulls',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: _height * 0.03),
                Padding(
                  padding: EdgeInsets.only(
                      left: _width * 0.05, right: _width * 0.05),
                  child: Text(
                    "We develop trading robots that research for you on the basis of past market experiences and of traders' current emotions.",
                    style: TextStyle(
                        color: Color.fromARGB(221, 1, 1, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
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
                SizedBox(height: _height * 0.15),
                Padding(
                  padding: EdgeInsets.only(
                      left: _width * 0.05, right: _width * 0.05),
                  child: Text('Invest with ease',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: _height * 0.03),
                Padding(
                  padding: EdgeInsets.only(
                      left: _width * 0.05, right: _width * 0.05),
                  child: Text(
                    "Choose your trading bot and invest your favourite asset.",
                    style: TextStyle(
                        color: Color.fromARGB(221, 1, 1, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/three.jpeg',
                  fit: BoxFit.fill,
                ),
                SizedBox(height: _height * 0.15),
                Padding(
                  padding: EdgeInsets.only(
                      left: _width * 0.05, right: _width * 0.05),
                  child: Text('Unsure about your investment? Try the Demo',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: _height * 0.03),
                Padding(
                  padding: EdgeInsets.only(
                      left: _width * 0.05, right: _width * 0.05),
                  child: Text(
                    "We offer users the possibility to invest in all of our trading bots with fake money in order to see over some days/weeks/months how the investment evolves",
                    style: TextStyle(
                        color: Color.fromARGB(221, 1, 1, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                ),
              ],
            )
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Color.fromARGB(255, 36, 57, 146),
            width: _width * 0.8,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WebviewScreen()),
                );
              },
              child: const Text(
                'Get Started',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
