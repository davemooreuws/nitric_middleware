import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sturdy_http/sturdy_http.dart';
import 'package:dio/dio.dart' show InterceptorsWrapper;

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(helloProvider);
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

final helloProvider = FutureProvider<String>((ref) async {
  final client = ref.watch(apiClientProvider('http://localhost:4001'));

  return client.execute<String, String>(
    const GetRequest('/hello/Ryan'),
    onResponse: (r) {
      return r.maybeWhen(
        ok: (greeting) => greeting,
        orElse: () => '',
      );
    },
  );
});

final apiClientProvider = Provider.family<SturdyHttp, String>((ref, baseUrl) {
  return SturdyHttp(
    baseUrl: baseUrl,
    interceptors: [
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers.addAll({
            "Authorization": "Bearer",
          });

          handler.next(options);
        },
      )
    ],
  );
});
