import { api } from "@nitric/sdk";

const corsMiddleware = async (ctx, next) => {
  ctx.res.headers["Access-Control-Allow-Origin"] = ["*"];
  ctx.res.headers["Access-Control-Allow-Headers"] = [
    "Origin, Content-Type, Accept, Authorization",
  ];
  ctx.res.headers["Access-Control-Allow-Methods"] = ["GET,POST,DELETE,OPTIONS"];

  console.log("CORS Middleware");

  return next(ctx);
};

const helloApi = api("main", {
  middleware: [corsMiddleware],
});

helloApi.options("/hello/:name", async (ctx) => {
  ctx.res.body = "OK";

  return ctx;
});

helloApi.get("/hello/:name", async (ctx) => {
  const { name } = ctx.req.params;

  ctx.res.body = `Hello ${name}`;

  return ctx;
});
