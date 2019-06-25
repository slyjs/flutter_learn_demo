import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartBottom extends StatelessWidget {
  const CartBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      color: Colors.white,
      width: ScreenUtil().setWidth(720),
      child: Row(
        children: <Widget>[
          _selectAllBtn(),
          _allPriceArea(),
          _goButton(),
        ],
      ),
    );
  }

  Widget _selectAllBtn() {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: true,
            activeColor: Colors.pink,
            onChanged: (bool val) {
              //全选的按钮点击事件
            },
          ),
          Text('全选'),
        ],
      ),
    );
  }

  Widget _allPriceArea() {
    return Container(
      width: ScreenUtil().setWidth(400),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计：',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(180),
                  child: Text(
                    '￥1992',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(36),
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(380),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(22),
              ),
            ),
          ),
        ],
      ),
    );
  }

//结算按钮
  Widget _goButton() {
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            '结算(6)',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
