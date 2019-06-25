import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cartinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  String cartKeySP = 'cartInfo';
  List<CartInfoModel> cartModelList = [];
  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(cartKeySP);
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    var isHave = false;
    int ival = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        isHave = true;
        tempList[ival]['count'] = item['count'] + 1;
        cartModelList[ival].count++;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };
      tempList.add(newGoods);
      cartModelList.add(new CartInfoModel.fromJson(newGoods));
    }
    cartString = json.encode(tempList).toString();
    // print(cartString);
    // print(cartModelList.toString());
    prefs.setString(cartKeySP, cartString);

    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(cartKeySP);
    // print('清空完成');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(cartKeySP);
    cartModelList = [];
    if (cartString == null) {
      cartModelList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
        cartModelList.add(new CartInfoModel.fromJson(item));
      });
    }

    notifyListeners();
  }
}
