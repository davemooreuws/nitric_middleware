import 'package:nitric_sdk/nitric.dart';

Future<HttpContext> corsMiddleware(HttpContext ctx) {
  ctx.res.headers['Access-Control-Allow-Origin'] = ['*'];
  ctx.res.headers['Access-Control-Allow-Headers'] = [
    'Origin, Content-Type, Accept, Authorization',
  ];
  ctx.res.headers['Access-Control-Allow-Methods'] = ['GET,POST,DELETE,OPTIONS'];

  print("CORS Middleware");

  return ctx.next();
}

void main(List<String> arguments) {
  final api = Nitric.api(
    "hello",
    opts: ApiOptions(middlewares: List.from([corsMiddleware])),
  );

  api.options("/hello/:name", (ctx) async {
    print("Hello API Options");

    ctx.res.body = "Hello Options";

    return ctx.next();
  });

  api.get("/hello/:name", (ctx) async {
    print("Hello API");

    final name = ctx.req.pathParams["name"]!;

    ctx.res.body = "Hello $name";

    return ctx.next();
  });
}
