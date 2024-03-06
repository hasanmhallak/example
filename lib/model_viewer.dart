// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart' as android;
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart' as ios;

import 'server.dart';

class ModelViewer extends StatefulWidget {
  const ModelViewer({super.key});
  @override
  State<ModelViewer> createState() => _ModelViewerState();
}

class _ModelViewerState extends State<ModelViewer> {
  late final WebViewController _controller;

  @override
  void initState() {
    late final PlatformWebViewControllerCreationParams params;
    if (Platform.isAndroid) {
      params = android.AndroidWebViewControllerCreationParams();
    } else if (Platform.isIOS) {
      params = ios.WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
      );
    }

    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      );

    Server.initServer().then((uri) => _controller.loadRequest(uri));

    super.initState();
  }

  @override
  void dispose() {
    Server.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: () {
            _controller.runJavaScript('switchSrc("Chair")');
          }),
          FloatingActionButton(onPressed: () {
            _controller.runJavaScript('switchSrc("Canoe")');
          }),
          FloatingActionButton(onPressed: () {
            _controller.runJavaScript('switchSrc("GeoPlanter")');
          }),
          FloatingActionButton(onPressed: () {
            _controller.runJavaScript('switchSrc("Mixer")');
          }),
          FloatingActionButton(onPressed: () {
            _controller.runJavaScript('switchSrc("ToyTrain")');
          }),
        ],
      ),
      body: WebViewWidget(
        controller: _controller,
        gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(EagerGestureRecognizer.new),
        },
      ),
    );
  }
}
