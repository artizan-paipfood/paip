import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

class Go {
  late BuildContext context;

  Go._(this.context);

  factory Go.of(BuildContext context) {
    return Go._(context);
  }

  void goNamed(String name, {Map<String, String> pathParameters = const {}}) {
    context.goNamed(name, pathParameters: pathParameters);
  }

  void go(String path) {
    context.go(path);
  }

  void goNamedNeglect(String name, {Map<String, String> pathParameters = const {}}) {
    if (isWeb) return Router.neglect(context, () => context.goNamed(name, pathParameters: pathParameters));
    context.goNamed(name, pathParameters: pathParameters);
  }

  void goNeglect(String name) {
    if (isWeb) return Router.neglect(context, () => context.go(name));
    context.go(name);
  }

  void pushNamedNeglect(String name, {Map<String, String> pathParameters = const {}}) {
    if (isWeb) return Router.neglect(context, () => context.pushNamed(name, pathParameters: pathParameters));
    context.pushNamed(name, pathParameters: pathParameters);
  }

  void pushNeglect(String name, {Map<String, String> pathParameters = const {}}) {
    if (isWeb) return Router.neglect(context, () => context.push(name));
    context.push(name);
  }
}
