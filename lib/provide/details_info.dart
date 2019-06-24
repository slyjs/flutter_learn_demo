import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;
  //商品详情页面的详情和评论tabbar的状态切换 变量
  bool isLeft = true;
  bool isRight = false;
  getGoodsInfo(String goodsId) {
    var formData = {'goodId': goodsId};
    request(GET_DETAILS, formData: formData).then((val) {
      var responseData = json.decode(val.toString());
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }

  //商品详情页面的详情和评论tabbar的状态切换
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
  }
}
