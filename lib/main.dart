import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:provide/provide.dart';
import './pages/index_page.dart';
import './provide/category_goods_list.dart';
import 'package:fluro/fluro.dart';
import './routers/routes.dart';

// 工程启动main方法
void main() {
  //初始化Provide
  var childCategoryProvide = RightChildTopCategoryProvide();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var providers = Providers();
  providers
    ..provide(
        Provider<RightChildTopCategoryProvide>.value(childCategoryProvide))
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //初始化fluro 路由
    final router = Router();
    //
    Routes.configureRoutes(router);
    //路由对象的全局单利化
    Application.router = router;
    return Container(
      child: MaterialApp(
        //将自己配置的router和系统关联
        onGenerateRoute: Application.router.generator,
        title: "百姓生活+",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
