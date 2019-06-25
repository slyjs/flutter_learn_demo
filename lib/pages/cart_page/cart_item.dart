import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cartinfo.dart';

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
            _getCheckBox(),
            _getItemImage(cartItem),
            _getCartGoodsName(cartItem),
            _getCartPrice(cartItem),
          ],
        ),
      ),
    );
  }

  //子条目的复选框控件
  Widget _getCheckBox() {
    return Container(
      child: Checkbox(
        value: true,
        activeColor: Colors.pink,
        onChanged: (bool val) {
          //复选框的点击事件
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

  Widget _getCartGoodsName(cartItem) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(cartItem.goodsName),
        ],
      ),
    );
  }

  Widget _getCartPrice(cartItem) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${cartItem.price}'),
          Container(
            child: InkWell(
              onTap: () {},
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
