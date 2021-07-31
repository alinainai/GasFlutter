import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn_app/common/global.dart';

import '../../main.dart';

class ErrorCatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("异常测试"),
      ),
      body: _ErrorCatchWidget(),
    );
  }
}

class _ErrorCatchWidget extends StatefulWidget {
  @override
  State<_ErrorCatchWidget> createState() {
    return _ErrorCatchState("异常测试");
  }
}

class _ErrorCatchState extends State<_ErrorCatchWidget> {
  _ErrorCatchState(this._showText);

  String _showText = "";

  @override
  Widget build(BuildContext context) {
    //todo 测试布局 build 异常
    List<String> numList = ['1', '2'];
    print(numList[5]);
    return Column(
      children: [
        FlatButton(
            onPressed: () {
              logger.e("throw error");
              // List<String> numList = ['1', '2'];
              // print(numList[5]);
              Future.delayed(Duration(seconds: 1), () {
                final _ = 100 ~/ 0;
              });
            },
            child: Text(
              "异步异常",
              style: TextStyleMs.black_00_14,
            )),
        FlatButton(
            onPressed: () async {
              logger.e("throw error");
              // List<String> numList = ['1', '2'];
              // print(numList[5]);
              await Future.delayed(Duration(seconds: 1), () {
                final _ = 100 ~/ 0;
              });
            },
            child: Text(
              "同步异常",
              style: TextStyleMs.black_00_14,
            )),
        FlatButton(
            onPressed: () {
              List<String> numList = ['1', '2'];
              print(numList[5]);
            },
            child: Text(
              "同步异常",
              style: TextStyleMs.black_00_14,
            )),
        Text(_showText, style: TextStyleMs.red_00_14)
      ],
    );
  }
}
