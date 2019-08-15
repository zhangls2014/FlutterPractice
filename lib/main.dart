import 'package:flutter/material.dart';
import 'package:practice/page_unknown_route.dart';
import 'package:practice/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practice',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: Routes.PAGE_HOME,
      onUnknownRoute: (RouteSettings settings) =>
          MaterialPageRoute(builder: (context) => PageUnknownRoute()),
      routes: Routes.getRoutes(context),
    );
  }
}

// 首页列表 Item
class ListModel {
  String title;
  String subtitle;
  String routeName;

  ListModel({this.title, this.subtitle, this.routeName});
}

class MyHomePage extends StatelessWidget {
  final String title;
  final List<ListModel> _list = List();

  MyHomePage({Key key, this.title}) : super(key: key) {
    _list.add(ListModel(
        title: 'ListView', subtitle: '演示 ListView 的基本使用、滚动信息获取、控制方法', routeName: Routes.PAGE_LIST));
    _list.add(ListModel(
        title: 'AnimatedContianer',
        subtitle: '演示 AnimatedContainer 动画的基本使用方法',
        routeName: Routes.PAGE_ANIMATED_CONTAINER));
    _list.add(ListModel(
        title: 'Coustom Widget', subtitle: '演示自定义组件的基本方法', routeName: Routes.PAGE_CUSTOM_VIEW));
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
              onTap: () => Navigator.pushNamed(context, _list[index].routeName),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: _list.length),
    );
  }
}
