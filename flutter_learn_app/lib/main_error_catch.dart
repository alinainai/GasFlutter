import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_learn_app/src/advanced/error_catch_widget.dart';

import 'common/global.dart';

Future<Null> main() async {
  //要在 release 模式下运行，debug 版本下不能回调。Flutter 的一个bug https://github.com/flutter/flutter/issues/47447
  FlutterError.onError = (FlutterErrorDetails details) {
    print('ui exception');
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      //这里把异常抛给 runZoned() 统一处理
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  runZoned<Future<Null>>(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) async {
    //异常处理
    await _reportError(error, stackTrace);
  });
}

Future<Null> _reportError(Object error, StackTrace stackTrace) async {
  if (isInDebugMode) {
    print(
        "_reportError debug :error = ${error.toString()} stackTrace = ${stackTrace.toString()}");
    return;
  }
  //异常集中在这个地方处理
  print('_reportError release : error = ${error.toString()}');
}

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        Global.ROUTER_ERROR_CATCH: (context) => ErrorCatchScreen(),
      },
      home: MyHomePage(title: 'Error Catch'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    print('main build');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _generateFlatButtonClick("同步异常 try-catch 捕获", () {
            try {
              throw StateError('This is a Dart exception');
            } catch (e) {
              print("1.同步异常 try-catch 捕获------------------------------");
              print("同步异常 try - catch = ${e.toString()}");
            }
          }),
          _generateFlatButtonClick("异步异常 catchError 捕获", () {
            Future.delayed(Duration(seconds: 1)).then((e) {
              print("2.异步异常 catchError 捕获------------------------------");
              throw StateError('This is a Dart exception in Future.');
            }).catchError((e) => print("异步异常 catchError = ${e.toString()}"));
          }),
          _generateFlatButtonClick("异步异常 try-catch 捕获", () {
            try {
              Future.delayed(Duration(seconds: 1)).then((e) {
                print("3.异步异常 try-catch 捕获------------------------------");
                throw StateError('This is a Dart exception in Future');
              });
            } catch (e) {
              print("异步异常 try-catch 捕获 ${e.toString()}");
            }
          }),
          _generateFlatButtonClick("同步异常全局捕获", () {
            print("4.同步异常全局捕获------------------------------");
            throw StateError('This is a Dart exception in Future.');
          }),
          _generateFlatButtonClick("异步异常全局捕获", () {
            Future.delayed(Duration(seconds: 1)).then((e) {
              print("5.异步异常全局捕获------------------------------");
              throw StateError('This is a Dart exception in Future.');
            });
          }),
          _generateFlatButtonClick("build异常全局捕获", () {
            print("6.build异常全局捕获------------------------------");
            Navigator.pushNamed(context, Global.ROUTER_ERROR_CATCH);
          })
        ],
      ),
    );
  }

  FlatButton _generateFlatButtonClick(String title, Function click) {
    return FlatButton(
        color: Colors.green,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        colorBrightness: Brightness.light,
        onPressed: click,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Icon(Icons.add), Text(title)],
        ));
  }
}
