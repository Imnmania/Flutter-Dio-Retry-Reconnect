import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio_interceptor/interceptor/dio_connectivity_request_retrier.dart';
import 'package:flutter_dio_interceptor/interceptor/retry_interceptor.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dio dio;
  String firstPostTitle;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    dio = Dio();
    firstPostTitle = 'Press the button 👇';
    isLoading = false;

    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Dio Interceptor'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading) CircularProgressIndicator(),
            Text(firstPostTitle),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              child: Text('Request Data'),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                final response =
                    await dio.get("https://jsonplaceholder.typicode.com/posts");
                setState(() {
                  firstPostTitle = response.data[0]['title'] as String;
                  isLoading = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
