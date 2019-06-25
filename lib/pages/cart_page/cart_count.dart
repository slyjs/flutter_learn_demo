import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cartinfo.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

//购物车页面--商品的加减控件
class CartCount extends StatelessWidget {
  final CartInfoModel cartItem;
  const CartCount({Key key, this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: ScreenUtil().setWidth(170),
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black12),
        ),
        child: Row(
          children: <Widget>[
            //商品的加减控件区域
            _reduceBtn(context, cartItem),
            _countArea(context, cartItem),
            _addBtn(context, cartItem),
          ],
        ),
      ),
    );
  }

//减少按钮
  Widget _reduceBtn(context, CartInfoModel cartItem) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context)
            .addOrReduceAction(cartItem, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: cartItem.count == 1 ? Colors.black12 : Colors.white,
          border: Border(
            right: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: cartItem.count == 1 ? Text('') : Text('-'),
      ),
    );
  }

//添加按钮
  Widget _addBtn(context, CartInfoModel cartItem) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addOrReduceAction(cartItem, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: Text('+'),
      ),
    );
  }

  //显示数字的区域
  Widget _countArea(context, CartInfoModel cartItem) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${cartItem.count}'),
    );
  }
}
