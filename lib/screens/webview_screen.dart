import 'dart:io';
import 'package:app/data/image_paths.dart';
import 'package:app/services/firebase_message_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

late int scheck;
late WebViewController _controller;

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({Key? key}) : super(key: key);

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  bool _loading = true;
  bool _error = false;
  bool _pageNavigationLoading = false;
  double _progress = 0.0;
  final _key = UniqueKey();
  // late WebViewController _controller;
  static const appLogo = appIcon;
  static const url = 'https://app.robotbulls.com/';

  late bool check;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    check = false;
    FirebaseMessageService.startMessageListener(context);
    super.initState();
  }

  _scrollListener() {
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      _controller.reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          setState(() {
            _error = false;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 36, 57, 146),
        extendBody: true,
        body: SafeArea(
          child: Stack(
            children: [
              WebView(
                key: _key,
                gestureNavigationEnabled: true,
                initialUrl: url,
                zoomEnabled: false,
                javascriptMode: JavascriptMode.unrestricted,
                onProgress: (int progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                  if (progress == 100) {
                    setState(() {
                      _loading = false;
                    });
                  }
                },
                onPageStarted: (String url) {
                  setState(() {
                    _pageNavigationLoading = true;
                  });
                },
                onPageFinished: (String result) {
                  _pageNavigationLoading = false;
                  _controller.scrollBy(0, 5);
                },
                onWebViewCreated: (WebViewController controller) {
                  _controller = controller;
                },
                onWebResourceError: (WebResourceError error) {
                  setState(() {
                    _error = true;
                  });
                },
                gestureRecognizers: [
                  Factory(() => PlatformViewVerticalGestureRecognizer()),
                ].toSet(),
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.contains('addthis.com') ||
                      request.url.contains('sms:?') ||
                      request.url.contains('www.pinterest.com/pin')) {
                    _launchURL(request.url);
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
              if (_loading)
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: const Color.fromARGB(255, 36, 57, 146),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            appLogo,
                            height: 150,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CircularProgressIndicator(
                          value: _progress,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              if (_error)
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            'No Internet Connection',
                            style: TextStyle(
                              letterSpacing: 1.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Image.asset(
                              errorIcon,
                              width: double.infinity,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(
                              40,
                              10,
                              40,
                              40,
                            ),
                            child: Text(
                              'Please check your connection again or connect to wifi',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _controller.reload();
                              setState(() {
                                _error = false;
                                _loading = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              width: double.infinity,
                              alignment: Alignment.center,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Text(
                                'Retry',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              // if (_pageNavigationLoading && !_error && !_loading)
              //   const Center(
              //     child: SpinKitCircle(
              //       size: 50,
              //       color: Colors.red,
              //     ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class PlatformViewVerticalGestureRecognizer
    extends VerticalDragGestureRecognizer {
  PlatformViewVerticalGestureRecognizer();
  Offset _dragDistance = Offset.zero;

  @override
  void addPointer(PointerEvent event) {
    startTrackingPointer(event.pointer);
  }

  // @override
  // void handleEvent(PointerEvent event) {
  //   _dragDistance = _dragDistance + event.delta;
  //   _controller.getScrollY().then((value) {
  //     if (value < 2) {
  //       _controller.reload();
  //     }
  //   });
  // }

  @override
  String get debugDescription => 'horizontal drag (platform view)';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
