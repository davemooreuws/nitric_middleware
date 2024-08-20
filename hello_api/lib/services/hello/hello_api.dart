import 'package:nitric_sdk/nitric.dart';

void main(List<String> arguments) {
  final api = Nitric.api(
    "hello",
    opts: ApiOptions(middlewares: List.from([corsMiddleware])),
  );

  api.get("/hello/:name", (ctx) async {
    final name = ctx.req.pathParams["name"]!;

    ctx.res.body = "Hello $name";

    return ctx.next();
  });
}

Future<HttpContext> corsMiddleware(HttpContext ctx) {
  ctx.res.headers['Access-Control-Allow-Origin'] = ['*'];
  ctx.res.headers['Access-Control-Allow-Headers'] = [
    'Origin, Content-Type, Accept, Authorization',
  ];
  ctx.res.headers['Access-Control-Allow-Methods'] = ['GET,POST,DELETE,OPTIONS'];

  return ctx.next();
}
