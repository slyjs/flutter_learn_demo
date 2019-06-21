import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:provide/provide.dart';
import './pages/index_page.dart';
import './provide/category_goods_list.dart';

// 工程启动main方法
void main() {
  var childCategoryProvide = RightChildTopCategoryProvide();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var providers = Providers();
  providers
    ..provide(
        Provider<RightChildTopCategoryProvide>.value(childCategoryProvide))
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: "百姓生活+",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
