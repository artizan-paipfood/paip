class Exceptions {
  ///[_supabase], [_statusCode]
  Exceptions._();

  static String getError(String error, {required Map<String, String> exceptionMap, String? channel}) {
    error = error.toLowerCase().replaceFirst("exception: ", "").toLowerCase();
    return exceptionMap[error] ?? "Error: $error\nUnmapped, source: $channel";
  }

  static String getErrorStatusCode(int statusCode, {String? channel}) {
    return _statusCode[statusCode] ?? "Error: $statusCode\nUnmapped, source: $channel";
  }

  static final Map<String, String> supaBase = {
    "error": "Caraca mlk que isso",
  };
  static final Map<int, String> _statusCode = {
    200: "Caraca mlk que isso",
  };
}
