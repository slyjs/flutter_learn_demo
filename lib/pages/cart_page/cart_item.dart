import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../model/cartinfo.dart';
import 'cart_count.dart';
import '../../provide/cart.dart';

// 购物车子条目
class CartItem extends StatelessWidget {
  final CartInfoModel cartItem;
  const CartItem({Key key, this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: ScreenUtil().setWidth(720),
        margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _getCheckBox(context, cartItem),
            _getItemImage(cartItem),
            _getCartGoodsName(cartItem),
            _getCartPrice(context, cartItem),
          ],
        ),
      ),
    );
  }

  //子条目的复选框控件
  Widget _getCheckBox(context, CartInfoModel cartItem) {
    return Container(
      child: Checkbox(
        value: cartItem.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {
          //复选框的点击事件
          cartItem.isCheck = val;
          Provide.value<CartProvide>(context).changeCheckState(cartItem);
        },
      ),
    );
  }

  //子条目的图片控件
  Widget _getItemImage(cartItem) {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12,
        ),
      ),
      child: Image.network(cartItem.images),
    );
  }

  //商品名称
  Widget _getCartGoodsName(cartItem) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(cartItem.goodsName),
          CartCount(),
        ],
      ),
    );
  }

// 商品价格
  Widget _getCartPrice(context, cartItem) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${cartItem.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provide.value<CartProvide>(context)
                    .deleteOneGoods(cartItem.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
