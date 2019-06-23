import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;
  getGoodsInfo(String goodsId) {
    var formData = {'goodId': goodsId};
    request(GET_DETAILS, formData: formData).then((val) {
      var responseData = json.decode(val.toString());
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }
}
