import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'html.dart';

class Server {
  static HttpServer? _server;
  static StreamSubscription? _listener;

  Server._();

  static Future<Uri> initServer() async {
    _server = await HttpServer.bind('127.0.0.1', 5000);
    _addListener();
    return Uri.parse('http://${_server!.address.host}:${_server!.port}');
  }

  static void _addListener() async {
    _listener = _server?.listen(_requestHandler);
  }

  static Future<void> _requestHandler(HttpRequest req) async {
    final response = req.response;
    final path = req.uri.path;
    print(path);
    if (path == '/') {
      // final html = await loadAsset('assets/test2.html');
      // final html = await loadAsset('assets/test2.html');
      response
        ..statusCode = HttpStatus.ok
        ..headers.add('Content-Type', 'text/html; charset=UTF-8')
        ..headers.add('Content-Length', html.length.toString())
        ..add(html.codeUnits);

      await response.flush();
      await response.close();
      return;
    }

    if (path == '/model-viewer.min.js') {
      final js = await _loadAsset('assets/model-viewer.min.js');
      response
        ..statusCode = HttpStatus.ok
        ..headers.add('Content-Type', 'text/javaScript; charset=UTF-8')
        ..headers.add('Content-Length', js.length.toString())
        ..add(js);
      await response.flush();
      await response.close();
      return;
    }

    if (path == '/favicon.ico') {
      final text = utf8.encode("not found");
      response
        ..statusCode = HttpStatus.notFound
        ..headers.add('Content-Type', 'text/plain; charset=UTF-8')
        ..headers.add('Content-Length', text.length.toString())
        ..add(text);
      await response.close();
      return;
    }

    if (path.contains('glb') || path.contains('webp')) {
      final fileName = path.replaceAll('/', '');
      final model = _loadAsset('assets/shop_model/$fileName').asStream();
      response
        ..statusCode = HttpStatus.ok
        ..headers.add('Content-Type', 'application/octet-stream');
      await response.addStream(model);
      await response.flush();
      await response.close();
      return;
    }

    if (path == '/model-viewer.min.js.map') {
      final model = await _loadAsset('assets/model-viewer.min.js.map');

      response
        ..statusCode = HttpStatus.ok
        ..headers.add('Content-Type', 'application/json; charset=UTF-8')
        ..headers.add('Content-Length', model.length.toString())
        ..add(model);
      await response.flush();
      await response.close();
      return;
    }
  }

  static Future<Uint8List> _loadAsset(String path) async {
    final bytes = await rootBundle.load(path);
    return Uint8List.sublistView(bytes);
  }

  static void dispose() {
    _server?.close();
    _listener?.cancel();
  }
}
