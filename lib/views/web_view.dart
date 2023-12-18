import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyWebView extends StatefulWidget {
  final url;
  const PolicyWebView(this.url, {Key? key}) : super(key: key);

  @override
  State<PolicyWebView> createState() => _PolicyWebViewState(this.url);
}

class _PolicyWebViewState extends State<PolicyWebView> with TickerProviderStateMixin {
  var _url;
  final _key = UniqueKey();
  var loadingPercentage = 0;

  late final FlutterGifController gifController;
  late final WebViewController controller;

  _PolicyWebViewState(this._url);

  @override
  void initState() {
    super.initState();
    gifController= FlutterGifController(vsync: this);

    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
            // showGIFLoader();
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse(_url),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Flutter WebView'),
      // ),
      body: Stack(
          children:
          [
            WebViewWidget(
              controller: controller,
            ),
            if (loadingPercentage < 100)
              Center(
                child: Image(
                  image: const AssetImage('assets/images/loader_image.gif'),
                  width: MediaQuery.of(context).size.width*0.15,
                  height: MediaQuery.of(context).size.height*0.10,
                  // controller: gifController,
                ),
              ),
          ]
      ),
    );
  }

  void showGIFLoader() {

    GifImage(
      controller: gifController,
      image: AssetImage("images/loader_image.gif"),
    );
  }
}
