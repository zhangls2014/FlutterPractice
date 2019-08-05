import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView Demo')),
      body: _customScrollView,
    );
  }

  // 简单的列表，用于数量很少的场景
  final ListView _listTile = ListView(
    itemExtent: 50,
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.map),
        title: Text('Map'),
        subtitle: Text('this is a map subtitle'),
      ),
      ListTile(
        leading: Icon(Icons.mail),
        title: Text('Mail'),
        subtitle: Text('This is a mail subtitle'),
      ),
      ListTile(
        leading: Icon(Icons.message),
        title: Text('Message'),
        subtitle: Text('This is a message subtitle'),
      ),
    ],
  );

  // 采用 builder 构建列表
  final ListView _listView = ListView.builder(
    itemCount: 20,
    itemBuilder: (BuildContext context, int index) => Column(
      children: <Widget>[
        ListTile(
          title: Text('title $index'),
          subtitle: Text('body $index'),
        ),
        Divider(color: Colors.grey)
      ],
    ),
  );

  // 采用 separated 构建列表
  final ListView _listViewDivider = ListView.separated(
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey),
      itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text('title $index'),
            subtitle: Text('body $index'),
          ));

  // 自定义滑动列表
  final CustomScrollView _customScrollView = CustomScrollView(
    slivers: <Widget>[
      SliverAppBar(
        leading: Text(''),
        floating: true,
        expandedHeight: 180,
        flexibleSpace: Image.network(
          'https://cdn.britannica.com/s:700x450/33/153433-004-E1DFD1CB.jpg',
          fit: BoxFit.cover,
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
                  title: Text('title $index'),
                  subtitle: Text('body $index'),
                ),
            childCount: 20),
      )
    ],
  );
}

class ListViewControllerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListViewControllerState();
  }
}

class ListViewControllerState extends State<ListViewControllerWidget> {
  // ListView 控制器
  ScrollController _controller;

  // 标示目前是否需要启用 "Top" 按钮
  bool _isTop = false;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset > 300) {
        setState(() {
          _isTop = true;
        });
      } else {
        setState(() {
          _isTop = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ListView Demo')),
        floatingActionButton: _isTop
            ? FloatingActionButton(
                child: Text('TOP'),
                onPressed: (() {
                  _controller.animateTo(.0,
                      duration: Duration(milliseconds: 200), curve: Curves.ease);
                }),
              )
            : null,
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
              print('Scroll Start');
            } else if (scrollNotification is ScrollUpdateNotification) {
              print('Scroll Update');
            } else if (scrollNotification is ScrollEndNotification) {
              print('Scroll End');
            } else {
              return false;
            }
            return true;
          },
          child: CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              SliverAppBar(
                leading: Text(''),
                floating: true,
                expandedHeight: 180,
                flexibleSpace: Image.network(
                  'https://cdn.britannica.com/s:700x450/33/153433-004-E1DFD1CB.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => ListTile(
                          title: Text('title $index'),
                          subtitle: Text('body $index'),
                        ),
                    childCount: 20),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
