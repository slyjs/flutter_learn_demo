import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import '../config/httpHeaders.dart';

// 公用的网络请求方法
Future request(rqUrl, {formData}) async {
  try {
    print('开始获取数据...........rqurl==' + rqUrl);
    Response response;
    Dio dio = new Dio();
    // dio.options.headers = HttpHeaders;
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded;charset=UTF-8");

    if (rqUrl == HOMEPAGE_CONTENT) {
      response = await dio
          .get(servicePath[rqUrl] + "?lon=115.075234375&lat=35.776455078125");
    } else if (formData == null) {
      response = await dio.post(servicePath[rqUrl]);
    } else {
      response = await dio.post(servicePath[rqUrl], data: formData);
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
