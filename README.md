An example memoize function implementation in Dart. 

[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

## Usage

A simple usage example:

```dart
import 'package:memoize/memoize.dart';

main() {
  var uniqueId = 0;
  final generate = (String prefix) => ++uniqueId;
  final memoizedCalc = memoize(generate);
  var val1 = memoizedCalc('item');
  var val2 = memoizedCalc('item');
  print('equal: ${val1 == val2}'); // will be true
}

```
