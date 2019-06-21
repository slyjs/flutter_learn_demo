import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:provide/provide.dart';

//分类页面--右侧顶部的小分类数据模型的状态管理
class RightChildTopCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  //点击的小分类索引
  int childIndex = 0;
  String leftCategoryId = '4';
  String subId = ""; //小类的id
  getChildCategory(List<BxMallSubDto> list, String leftCategoryid) {
    leftCategoryId = leftCategoryid;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  changeChildIndex(index, String subid) {
    childIndex = index;
    subId = subid;
    notifyListeners();
  }
}
