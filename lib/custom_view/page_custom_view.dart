import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'combination_widget.dart';
import 'custom_painter.dart';

class PageCustomView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PageCustomViewState();
  }
}

class PageCustomViewState extends State<PageCustomView> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('组合控件演示'),
        bottom: TabBar(
          tabs: <Widget>[Tab(icon: Icon(Icons.system_update), text: "组合"), Tab(icon: Icon(Icons.cake), text: "自绘")],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[CombinationListWidget(), CustomPainterWidget()],
      ),
    );
  }
}

class CombinationListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CombinationListState();
  }
}

class CombinationListState extends State<CombinationListWidget> with AutomaticKeepAliveClientMixin {
  final List<UpdateItemModel> _list = List();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _list.add(UpdateItemModel(
        appIcon: 'assets/ic_google_maps.webp',
        appName: 'Google Maps - 为 Android 手机和平板电脑量身打造的 Google 地图',
        appDate: '2019年6月9号',
        appSize: "137.2",
        appVersion: "Version 5.19",
        appDescription:
            'Thanks for using Google Maps! This release brings bug fixes that improve our product to help you discover new places and navigate to them.'));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) => UpdateItemWidget(_list[index]),
        separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
        itemCount: _list.length);
  }
}

class CustomPainterWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CustomPainterState();
  }
}

class CustomPainterState extends State<CustomPainterWidget> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: CakeWidget(),
    );
  }
}
