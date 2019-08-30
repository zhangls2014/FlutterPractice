import 'package:flutter/material.dart';
import 'package:practice/routes.dart';

// 首页列表 Item
class ListModel {
  String title;
  String subtitle;
  String routeName;

  ListModel({this.title, this.subtitle, this.routeName});
}

class PageHomeWidget extends StatelessWidget {
  final List<ListModel> _list = List();

  PageHomeWidget() {
    _list.add(ListModel(title: 'ListView', subtitle: '演示 ListView 的基本使用、滚动信息获取、控制方法', routeName: Routes.PAGE_LIST));
    _list.add(ListModel(
        title: 'AnimatedContianer',
        subtitle: '演示 AnimatedContainer 动画的基本使用方法',
        routeName: Routes.PAGE_ANIMATED_CONTAINER));
    _list.add(ListModel(title: 'Coustom Widget', subtitle: '演示自定义组件的基本方法', routeName: Routes.PAGE_CUSTOM_VIEW));
    _list.add(ListModel(title: '天气信息展示', subtitle: '演示第三方网络框架 dio 的使用', routeName: Routes.PAGE_WEATHER));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ModalRoute
          .of(context)
          .settings
          .arguments as String)),
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
