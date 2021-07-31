import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_learn_app/src/advanced/animal_learn.dart';
import 'package:flutter_learn_app/src/advanced/error_catch_widget.dart';
import 'package:flutter_learn_app/src/advanced/http_learn_wight.dart';
import 'package:flutter_learn_app/src/advanced/local_storage_widget.dart';
import 'package:flutter_learn_app/src/learn/compose_widget.dart';
import 'package:flutter_learn_app/src/learn/base_wight.dart';
import 'package:flutter_learn_app/src/learn/custom_widget.dart';
import 'package:flutter_learn_app/src/learn/gesture_widget.dart';
import 'package:flutter_learn_app/src/learn/list_widget.dart';
import 'package:flutter_learn_app/src/learn/share_data_widget.dart';
import 'package:flutter_learn_app/src/learn/slider_wight.dart';
import 'package:flutter_learn_app/src/module/counter_numbers_screen.dart';
import 'package:flutter_learn_app/src/newroute/newroute.dart';
import 'package:flutter_learn_app/src/wight/customwidget.dart';
import 'package:logger/logger.dart';

import 'common/global.dart';

var logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        // number of method calls to be displayed
        errorMethodCount: 8,
        // number of method calls to be displayed
        lineLength: 120,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: false,
        // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp),
        ));

Future<Null> main() async {
  //显示
  // debugPaintSizeEnabled = true;
  //https://juejin.cn/post/6844903940497244167
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        Global.ROUTER_NEW_PAGE: (context) =>
            NewRoute(text: ModalRoute.of(context).settings.arguments),
        Global.ROUTER_PARENT_WIGHT: (context) => BaseWight(),
        Global.ROUTER_COMPOS_WIDGET: (context) => ComposeWidget(),
        Global.ROUTER_GESTURE_WIGHT: (context) => GestureWight(),
        Global.ROUTER_LIST_WIDGET: (context) => ListWidget(),
        Global.ROUTER_ANIMAL_WIDGET: (context) => AnimationLearnWidget(),
        Global.ROUTER_HTTP_LEARN: (context) => HttpLearnWidget(),
        Global.ROUTER_CUSTOM_WIDGET: (context) => CustomWidget(),
        Global.ROUTER_SHARE_DATA: (context) => ShowShareDataWidget(),
        Global.ROUTER_LOCAL_STORAGE: (context) => LocalStorageWidget(),
        Global.ROUTER_PROVIDER_LEARN: (context) => CounterNumberScreen(),
        Global.ROUTER_ERROR_CATCH: (context) => ErrorCatchScreen(),
      },
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() {
    print('create main state');
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;

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
          // RandomWordsWidget(),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
          _generateFlatButtonClick("跳转到基础wight界面", () async {
            var result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return NewRoute(text: "我是传过来的数据");
            }));
            print("收到的数据=$result");
          }),
          _generateFlatButtonClick(
              "跳转到基础wight界面",
              () => Navigator.pushNamed(context, Global.ROUTER_PARENT_WIGHT,
                      arguments: "Hey")
                  .then((msg) => print("from b page data = $msg"))),
          _generateFlatButtonClick("打印日志", () {
            // Navigator.pushNamed(context, Global.ROUTER_PARENT_WIGHT);
            logger.e('error');
          }),
          _generateFlatButton("layout界面", Global.ROUTER_COMPOS_WIDGET),
          _generateFlatButton("监听事件界面", Global.ROUTER_GESTURE_WIGHT),
          _generateFlatButton("listView的使用", Global.ROUTER_LIST_WIDGET),
          _generateFlatButton("动画", Global.ROUTER_ANIMAL_WIDGET),
          _generateFlatButton("http 请求", Global.ROUTER_HTTP_LEARN),
          _generateFlatButton("自定义widget", Global.ROUTER_CUSTOM_WIDGET),
          _generateFlatButton("数据共享", Global.ROUTER_SHARE_DATA),
          _generateFlatButton("数据持久化", Global.ROUTER_LOCAL_STORAGE),
          _generateFlatButton("provider用法", Global.ROUTER_PROVIDER_LEARN),
          _generateFlatButton("异常捕获", Global.ROUTER_ERROR_CATCH)
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  FlatButton _generateFlatButton(String title, String router) {
    return FlatButton(
        // 设置背景色为黄色
        color: Colors.green,
        // 设置斜角矩形边框
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        // 确保文字按钮为深色
        colorBrightness: Brightness.light,
        onPressed: () => {Navigator.pushNamed(context, router)},
        // onPressed: () => {Navigator.pushNamed(context, Global.ROUTER_PARENT_WIGHT)},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Icon(Icons.add), Text(title)],
        ));
  }

  FlatButton _generateFlatButtonClick(String title, Function click) {
    return FlatButton(
        // 设置背景色为黄色
        color: Colors.green,
        // 设置斜角矩形边框
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        // 确保文字按钮为深色
        colorBrightness: Brightness.light,
        onPressed: click,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Icon(Icons.add), Text(title)],
        ));
  }

  void _incrementCounter() {
    print('main setState');
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    print('init main state');
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    print('main did change dependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    print('main did update widget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('main deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('main dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void reassemble() {
    print('main reassemble');
    super.reassemble();
  }

  //监听app的生命周期，在 initState 绑定，在 dispose 移除
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('main didChangeAppLifecycleState $state');
  }
}
