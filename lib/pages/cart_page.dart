import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 购物车页面

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('购物车'),
        ),
        body: FutureBuilder(
          future: _getCartInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List cartList = Provide.value<CartProvide>(context).cartModelList;
              return ListView.builder(
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      cartList[index].goodsName,
                    ),
                  );
                },
              );
            } else {
              return Text('正在加载中');
            }
          },
        ),
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
