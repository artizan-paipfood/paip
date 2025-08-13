class SerializationException extends Error {
  final Map map;
  final String runTimeType;
  @override
  final StackTrace stackTrace;
  SerializationException({required this.map, required this.runTimeType, required this.stackTrace});

  @override
  String toString() {
    final stackTraceString = stackTrace
        .toString()
        .split('\n')
        .where((line) => line.contains('.dart'))
        .take(3) // Pega apenas as 3 primeiras linhas que contêm .dart
        .map((line) => line.trim())
        .join('\n');

    return 'SerializationException: $runTimeType \nmap: $map \nStack Trace:\n$stackTraceString';
  }
}
