import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';

class DetailsBottom extends StatelessWidget {
  const DetailsBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(720),
      color: Colors.white,
      height: ScreenUtil().setHeight(100),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(100),
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.red,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(310),
              height: ScreenUtil().setHeight(100),
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(310),
              height: ScreenUtil().setHeight(100),
              color: Colors.red,
              child: Text('马上购买',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(28),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
