import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn_app/common/global.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("数据持久化"),
      ),
      body: Column(
        children: [
          FlatButton(
              color: Colors.green,
              // 设置斜角矩形边框
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () => {writeContent("我是一个文本")},
              child: Text(
                "写本地文件",
                style: TextStyleMs.white_00_14,
              )),
          FlatButton(
              color: Colors.green,
              // 设置斜角矩形边框
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () =>
                  {readContent().then((value) => print("读取文本=${value}"))},
              child: Text(
                "读本地文件",
                style: TextStyleMs.white_00_14,
              )),
          FlatButton(
              color: Colors.green,
              // 设置斜角矩形边框
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () => {
                    // 递增 counter 数据后，再次读出并打印
                    _incrementCounter().then((_) {
                      _loadCounter().then((value) => print("after:$value"));
                    })
                  },
              child: Text(
                "写SharedPreferences",
                style: TextStyleMs.white_00_14,
              )),
          FlatButton(
              color: Colors.green,
              // 设置斜角矩形边框
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () => {
                    // 读出 counter 数据并打印
                    _loadCounter().then((value) => print("before:$value"))
                  },
              child: Text(
                "读SharedPreferences",
                style: TextStyleMs.white_00_14,
              )),
        ],
      ),
    );
  }
}

// 创建文件目录
Future<File> get _localFile async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  print("path=$path");
  return File('$path/content.txt');
}

// 将字符串写入文件
Future<File> writeContent(String content) async {
  final file = await _localFile;
  return file.writeAsString(content);
}

// 从文件读出字符串
Future<String> readContent() async {
  try {
    final file = await _localFile;
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return "";
  }
}

// 读取 SharedPreferences 中 key 为 counter 的值
Future<int> _loadCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0);
  return counter;
}

// 递增写入 SharedPreferences 中 key 为 counter 的值
Future<void> _incrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
  prefs.setInt('counter', counter);
}
