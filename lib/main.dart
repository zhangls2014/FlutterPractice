import 'package:flutter/material.dart';
import 'package:practice/animated_container.dart';
import 'package:practice/combination_widget.dart';
import 'package:practice/listview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practice',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Practice Home Page'),
    );
  }
}

// 首页列表 Item
class ListModel {
  String title;
  String subtitle;
  Widget widget;

  ListModel({this.title, this.subtitle, this.widget});
}

class MyHomePage extends StatelessWidget {
  final String title;
  final List<ListModel> _list = List();

  MyHomePage({Key key, this.title}) : super(key: key) {
    _list.add(
        ListModel(title: 'ListView', subtitle: '演示 ListView 的基本使用方法', widget: ListViewWidget()));
    _list.add(ListModel(
        title: 'CustomScrollView',
        subtitle: '演示 ListView 的滚动信息获取和控制方法',
        widget: ListViewControllerWidget()));
    _list.add(ListModel(
        title: 'AnimatedContianer',
        subtitle: '演示 AnimatedContainer 动画的基本使用方法',
        widget: AnimatedContainerWidget()));
    _list.add(
        ListModel(title: 'Coustom Widget', subtitle: '演示自定义组件的基本方法', widget: CustomViewWidget()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_list[index].title),
              subtitle: Text(_list[index].subtitle),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => _list[index].widget));
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: _list.length),
    );
  }
}
