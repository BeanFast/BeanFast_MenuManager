import 'package:logger/logger.dart';

var logger = Logger(
    printer: PrettyPrinter(
      stackTraceBeginIndex: 1,
      methodCount: 1,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: false,
      printTime: false,
      noBoxingByDefault: true,
    ),
  );