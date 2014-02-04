library jstransformer;

import "dart:io";
import "dart:async";

void jstransform(String fromFile, String toFile) {
  RegExp exp = new RegExp(r"(while\s*\(.+\))(;)(\s*\belse\b)"); // OK

  var file = new File(fromFile);
  Future<String> finishedReading = file.readAsString();
  finishedReading.then((str) {
    Iterable<Match> matches = exp.allMatches(str);

    var transformed = str.replaceAllMapped(exp, (match) {
      return match.group(1) + match.group(3);
    });

    var file = new File(toFile);
    file.writeAsString(transformed, mode: FileMode.WRITE, flush: true);
  });
}