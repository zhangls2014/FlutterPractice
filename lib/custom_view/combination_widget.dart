import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateItemModel {
  String appIcon; //App 图标
  String appName; //App 名称
  String appSize; //App 大小
  String appDate; //App 更新日期
  String appDescription; //App 更新文案
  String appVersion; //App 版本
  // 构造函数语法糖，为属性赋值
  UpdateItemModel({this.appIcon, this.appName, this.appSize, this.appDate, this.appDescription, this.appVersion});
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
          DescriptionWidget(model: model),
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
                  child: Text(model.appDate, maxLines: 1, style: TextStyle(color: Colors.grey, fontSize: 14)),
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
  final UpdateItemModel model;

  DescriptionWidget({Key key, this.model}) : super(key: key);

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
