import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cartinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

//购物车状态管理--添加购物车，从购物车中删除某个商品，单选，全选商品，结算商品
class CartProvide with ChangeNotifier {
  String cartString = '[]';
  String cartKeySP = 'cartInfo';
  List<CartInfoModel> cartModelList = [];
  double allPrice = 0; //总价格
  int allGoodsCount = 0; //商品的总数量
  bool isAllCheck = true;

//加入购物车
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

  //完全清空购物车
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(cartKeySP);
    // print('清空完成');
    notifyListeners();
  }

  //获取购物车的持久化存储数据
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(cartKeySP);
    cartModelList = [];
    if (cartString == null) {
      cartModelList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      tempList.forEach((item) {
        if (item['isCheck']) {
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        } else {
          isAllCheck = false;
        }
        cartModelList.add(new CartInfoModel.fromJson(item));
      });
    }

    notifyListeners();
  }

  //删除商品的方法
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(cartKeySP);
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int deleteIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        deleteIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(deleteIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString(cartKeySP, cartString);
    await getCartInfo();
  }

  //单个商品的复选框选择事件的状态改变
  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartString = prefs.getString(cartKeySP);
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList[changeIndex] = cartItem.toJson(); //把对象变成map值
    cartString = json.encode(tempList).toString();
    prefs.setString(cartKeySP, cartString);
    await getCartInfo();
  }

  changeAllCheckState(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(cartKeySP);
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newCheckList = [];
    tempList.forEach((item) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newCheckList.add(newItem);
    });

    cartString = json.encode(newCheckList).toString();
    prefs.setString(cartKeySP, cartString);
    await getCartInfo();
  }

  //增加或者减少商品的数量
  addOrReduceAction(var cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(cartKeySP);
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }

    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString(cartKeySP, cartString);
    await getCartInfo();
  }
}
