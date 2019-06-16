import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

//获取首页主题内容
// Future getHomePageContent() async {
//   try {
//     print('开始获取首页数据...........');
//     Response response;
//     Dio dio = new Dio();
//     //发送时候的请求类型
//     dio.options.contentType =
//         ContentType.parse('application/w-www-form-urlencoded');
//     // var formData = {'lon': '115.075234375', 'lat': '35.776455078125'};
//     response = await dio.get(servicePath['homePageContent'] +
//         "?lon=115.075234375&lat=35.776455078125");
//     // print(response.data);
//     if (response.statusCode == 200) {
//       return response.data;
//     } else {
//       throw Exception('后端接口出现异常');
//     }
//   } catch (e) {
//     print('ERROR:=====>$e');
//   }
// }

// Future getHomePageBelowContent() async {
//   try {
//     print('开始获取下拉列表数据.................');
//     Response response;
//     Dio dio = new Dio();
//     dio.options.contentType =
//         ContentType.parse("application/x-www-form-urlencoded");
//     int page = 1;
//     response = await dio.post(servicePath['homePageBelowContent'], data: page);
//     if (response.statusCode == 200) {
//       return response.data;
//     } else {
//       throw Exception("后端接口出现异常");
//     }
//   } catch (e) {
//     return print('ERROR:======>$e');
//   }
// }

Future request(rqUrl, {formData}) async {
  try {
    print('开始获取首页数据...........rqurl==' + rqUrl);
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    if (formData == null) {
      response = await dio.get(servicePath[HOMEPAGE_CONTENT] +
          "?lon=115.075234375&lat=35.776455078125");
    } else {
      int page = 1;
      response =
          await dio.post(servicePath['homePageBelowContent'], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    print("ERROR:=====>$e");
  }
}
