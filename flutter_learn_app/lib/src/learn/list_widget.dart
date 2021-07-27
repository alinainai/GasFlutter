// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SlipperAppBar();
    //   Scaffold(
    //   appBar: AppBar(
    //     title: Text("listView的使用"),
    //   ),
    //   body: Container(padding: EdgeInsets.all(10), child: _SeparatorListView()
    //       // _RecyclerListView(),
    //       // _HorizontalListWidget(),
    //       ),
    // );
  }
}

//一次性创建好全部子View
class _DefaultListViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(leading: Icon(Icons.map), title: Text('Map')),
        ListTile(leading: Icon(Icons.mail), title: Text('Mail')),
        ListTile(leading: Icon(Icons.message), title: Text('Message')),
      ],
    );
  }
}

class _HorizontalListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.horizontal,
        itemExtent: 140, //item 延展尺寸 (宽度)
        children: <Widget>[
          Container(color: Colors.black),
          Container(color: Colors.red),
          Container(color: Colors.blue),
          Container(color: Colors.green),
          Container(color: Colors.yellow),
          Container(color: Colors.orange),
        ]);
  }
}

class _RecyclerListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 100, // 元素个数
        itemExtent: 50.0, // 列表项高度
        itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text("title $index"), subtitle: Text("body $index")));
  }
}

class _SeparatorListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: 100,
        separatorBuilder: (BuildContext context, int index) => index % 2 == 0
            ? Divider(color: Colors.green)
            : Divider(color: Colors.red), //index 为偶数，创建绿色分割线；index 为奇数，则创建红色分割线
        itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text("title $index"),
            subtitle: Text("body $index")) // 创建子 Widget
        );
  }
}

class _SlipperAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        //SliverAppBar 作为头图控件
        title: Text('CustomScrollView Demo'),
        // 标题
        floating: true,
        // 设置悬浮样式
        flexibleSpace:
            Image.asset("assets/images/beautiful_girl.jpeg", fit: BoxFit.cover),
        // 设置悬浮头图背景
        expandedHeight: 300, // 头图控件高度
      ),
      SliverList(
        //SliverList 作为列表控件
        delegate: SliverChildBuilderDelegate(
          (context, index) => ListTile(title: Text('Item #$index')),
          // 列表项创建方法
          childCount: 100, // 列表元素个数
        ),
      ),
    ]);
  }
}




