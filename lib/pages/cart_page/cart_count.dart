import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//购物车页面--商品的加减控件
class CartCount extends StatelessWidget {
  const CartCount({Key key}) : super(key: key);

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
            _reduceBtn(),
            _countArea(),
            _addBtn(),
          ],
        ),
      ),
    );
  }

//减少按钮
  Widget _reduceBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: Text('-'),
      ),
    );
  }

//添加按钮
  Widget _addBtn() {
    return InkWell(
      onTap: () {},
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
  Widget _countArea() {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('1'),
    );
  }
}
