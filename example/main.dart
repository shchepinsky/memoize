import 'dart:io';

import 'package:memoize/memoize.dart';

var calls = 0;

calculation(String prefix) {
  sleep(Duration(seconds: 1));
  var t0 = DateTime.now().millisecond;
  var items = List.generate(1000, (index) => '$prefix:$index');
  var t1 = DateTime.now().millisecond;
  var delta = t1 - t0;
  print('generated ${items.length} in $delta ms');
  return items;
}

final memoizedCalc = memoize(calculation);

main() {
  // the calculation function will simulate 'expensive calculation'
  // by delaying its output, however calling memoized function in a
  // loop results in only one delay, while other iterations output
  // memoized value since function is called with same arguments
  print('start');
  for (var i = 0; i < 5; i++) {
    var items = memoizedCalc('row');
    print('call #${1 + i}, item count: ${items.length}');
  }
  print('done');
}
