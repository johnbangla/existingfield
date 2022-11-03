import 'package:buro_employee/widgets/alert_dialog_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../app.dart';

class DialogInterceptor extends Interceptor {
  static const skipHeader = 'skipDialog';

  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    final context = MyApp.materialKey.currentContext;

    if (context == null) {
      print('Context null');
      return;
    }

    final response = err.response?.data;

    if (response == null) {
      return super.onError(err, handler);
    }

    if (!err.requestOptions.headers.containsKey(skipHeader)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialogWidget(
          title: "hgjgjgjgj",
          description: "hfjfhfjfh",
        ),
      );
    }

    return super.onError(err, handler);
  }
}
