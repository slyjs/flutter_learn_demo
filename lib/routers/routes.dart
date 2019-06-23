import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../routers/router_handler.dart';

class Routes {
  static String root = '/';
  static String detailsPage = '/detail';
  static void configureRoutes(Router router) {
    //配置找不到页面的情况下应该怎么处理
    router.notFoundHandler = new Handler(handlerFunc: (
      BuildContext context,
      Map<String, List<String>> params,
    ) {
      print('ERROR====>ROUTE WAS NOT FONUND!!!');
    });

    //定义detailpage页面，其他页面也类似这种配置
    router.define(
      detailsPage,
      handler: detailsPageHandler,
    );
  }
}
