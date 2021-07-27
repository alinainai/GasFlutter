import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn_app/common/global.dart';
import 'package:provider/provider.dart';

import 'counter_model.dart';

class CounterNumberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: CounterModel(), // 需要共享的数据资源
        child: FirstPage());
  }
}

// 第一个页面，负责读数据
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 取出资源
    final _counter = Provider.of<CounterModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("测试provider的使用"),
        ),
        // 展示资源中的数据
        body: Text(
          'Counter: ${_counter.counter}',
          style: TextStyleMs.black_00_14,
        ),
        // 跳转到 SecondPage
        floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SecondPageWrap()))));
  }
}

// 第二个页面，负责读写数据
class SecondPageWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: CounterModel(), // 需要共享的数据资源
        child: SecondPage());
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("测试provider的使用2"),
        ),
        // 展示资源中的数据
        body: Text(
          'Counter: ${_counter.counter}',
          style: TextStyleMs.black_00_14,
        ),
        // 用资源更新方法来设置按钮点击回调
        floatingActionButton: FloatingActionButton(
          onPressed: _counter.increment,
          child: Icon(Icons.add),
        ));
  }
}
