import 'package:flutter/widgets.dart';
import 'package:practice/custom_view/page_custom_view.dart';
import 'package:practice/main.dart';
import 'package:practice/page_animated_container.dart';

import 'page_listview.dart';

// route 统一管理类
class Routes {
  static const PAGE_HOME = "route_page_home";
  static const PAGE_LIST = "route_page_list";
  static const PAGE_ANIMATED_CONTAINER = "route_page_animated_container";
  static const PAGE_CUSTOM_VIEW = "route_page_custom_view";

  static Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    return {
      PAGE_HOME: (context) => MyHomePage(title: 'Flutter Practice Home Page'),
      PAGE_LIST: (context) => PageListViewWidget(),
      PAGE_ANIMATED_CONTAINER: (context) => PageAnimatedContainer(),
      PAGE_CUSTOM_VIEW: (context) => PageCustomView(),
    };
  }
}
