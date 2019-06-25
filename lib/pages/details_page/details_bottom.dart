import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_shop/provide/currentIndex.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';

class DetailsBottom extends StatelessWidget {
  const DetailsBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provide.value<DetailsInfoProvide>(context)
        .goodsInfo
        .detailsGoodsData
        .goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var presentPrice = goodsInfo.presentPrice;
    var iamges = goodsInfo.image1;
    return Container(
      width: ScreenUtil().setWidth(720),
      color: Colors.white,
      height: ScreenUtil().setHeight(100),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              Provide.value<CurrentIndexProvide>(context).changeIndex(2);
              Navigator.pop(context);
            },
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
            onTap: () {
              Provide.value<CartProvide>(context)
                  .save(goodsId, goodsName, count, presentPrice, iamges);
            },
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
            onTap: () {
              Provide.value<CartProvide>(context).remove();
            },
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
