import 'package:dart_frog/dart_frog.dart';
import 'package:api/infra/services/process_env.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart' as shelf;

/// Returns a [Middleware] that adds CORS headers to the response.
Middleware corsHeaders() => ProcessEnv.corsOrigin == '*'
    ? fromShelfMiddleware(
        shelf.corsHeaders(
          headers: {
            shelf.ACCESS_CONTROL_ALLOW_ORIGIN: ProcessEnv.corsOrigin,
            shelf.ACCESS_CONTROL_ALLOW_CREDENTIALS: 'true',
          },
        ),
      )
    : (handler) {
        return (context) {
          return handler(context);
        };
      };
