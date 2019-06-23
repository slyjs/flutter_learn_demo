import 'package:flutter/foundation.dart';

import '../model/categoryGoodsList.dart';

//分类页面--右侧的商品列表数据模型的状态管理
class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodslist = [];
  getGoodsList(List<CategoryListData> list) {
    goodslist = list;
    notifyListeners();
  }

  getMoreGoodsList(List<CategoryListData> list) {
    goodslist.addAll(list);
    notifyListeners();
  }
}
