import "dart:io";
import "dart:async";

main (List<String> arguments) {

  RegExp exp = new RegExp(r"(while\s*\(.+\))(;)(\s*\belse\b)"); // OK

  var file = new File(arguments[0]);
  Future<String> finishedReading = file.readAsString();
  finishedReading.then((str) {
    Iterable<Match> matches = exp.allMatches(str);
/*
    matches.forEach((match) {
      print("${match.groupCount} from ${match.start} to ${match.end} = '${match.group(0)}'");
    });
*/
    var transformed = str.replaceAllMapped(exp, (match) {
      return match.group(1) + match.group(3);
    });

    var file = new File(arguments[1]);
    file.writeAsString(transformed, mode: FileMode.WRITE, flush: true);
  });
}