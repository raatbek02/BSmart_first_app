import 'package:flutter/foundation.dart';
import 'package:logger/web.dart';

class NoopPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    // Do nothing
    return <String>[];
  }
}

Logger logger = kReleaseMode
    ? Logger(printer: NoopPrinter())
    : Logger(
        printer: PrettyPrinter(
          methodCount: 2, // number of method calls to be displayed
          errorMethodCount:
              5, // number of method calls if stacktrace is provided
          lineLength: 120, // width of the output
          colors: true, // Colorful log messages
          printEmojis: true, // Print an emoji for each log message
          excludePaths: [""],
          // printTime: true // Should each log print contain a timestamp
        ),
        output: ConsoleOutput(),
        filter:
            ProductionFilter(), // Use the PrettyPrinter to format and prin log
      );
