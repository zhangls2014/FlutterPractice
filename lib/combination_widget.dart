import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/custom_painter.dart';

class UpdateItemModel {
  String appIcon; //App 图标
  String appName; //App 名称
  String appSize; //App 大小
  String appDate; //App 更新日期
  String appDescription; //App 更新文案
  String appVersion; //App 版本
  // 构造函数语法糖，为属性赋值
  UpdateItemModel(
      {this.appIcon,
      this.appName,
      this.appSize,
      this.appDate,
      this.appDescription,
      this.appVersion});
}

class UpdateItemWidget extends StatelessWidget {
  final UpdateItemModel model;

  UpdateItemWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildTopRow(context),
          DescriptionWidget(model),
          Text("${model.appVersion} • ${model.appSize} MB")
        ],
      ),
    );
  }

  // 将第一行的构建独立出来，让代码更清晰
  Widget buildTopRow(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(model.appIcon, width: 80, height: 80),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.appName,
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(model.appDate,
                      maxLines: 1, style: TextStyle(color: Colors.grey, fontSize: 14)),
                )
              ],
            ),
          ),
        ),
        RaisedButton(
          child: Text('OPEN'),
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        )
      ],
    );
  }
}

class DescriptionWidget extends StatefulWidget {
  UpdateItemModel model;

  DescriptionWidget(this.model);

  @override
  State<StatefulWidget> createState() {
    return DescriptionState(model);
  }
}

class DescriptionState extends State<DescriptionWidget> {
  // 是否展开描述
  bool _isOpen = false;
  UpdateItemModel model;

  DescriptionState(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 30, 10),
              child: Text(
                model.appDescription,
                maxLines: _isOpen ? null : 2,
              ),
            ),
            Positioned(
                width: 80,
                height: 36,
                bottom: 0,
                right: 0,
                child: FlatButton(
                  color: Color.fromARGB(120, 255, 255, 255),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Text(
                    _isOpen ? 'close' : 'more',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    setState(() {
                      _isOpen = !_isOpen;
                    });
                  },
                ))
          ],
        ));
  }
}

class CustomViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CustomViewState();
  }
}

class CustomViewState extends State<CustomViewWidget> with SingleTickerProviderStateMixin {
  final List<UpdateItemModel> _list = List();
  TabController _tabController;

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
    _list.add(UpdateItemModel(
        appIcon: 'assets/ic_google_maps.webp',
        appName: 'Google Maps - 为 Android 手机和平板电脑量身打造的 Google 地图',
        appDate: '2019年6月9号',
        appSize: "137.2",
        appVersion: "Version 5.19",
        appDescription:
            'Thanks for using Google Maps! This release brings bug fixes that improve our product to help you discover new places and navigate to them.'));
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
          tabs: <Widget>[
            Tab(icon: Icon(Icons.system_update), text: "组合"),
            Tab(icon: Icon(Icons.cake), text: "自绘")
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListView.separated(
              itemBuilder: (BuildContext context, int index) => UpdateItemWidget(_list[index]),
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: _list.length),
          Center(
            child: CakeWidget(),
          )
        ],
      ),
    );
  }
}
