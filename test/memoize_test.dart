import 'package:memoize/memoize.dart';
import 'package:test/test.dart';

calculatePositional(int pos1) {
  return {
    ['pos1']: pos1
  };
}

calculatePositionalAndNamed(int pos1, {firstNamed: String, secondNamed: String}) {
  return {
    ['pos1']: pos1,
    ['named']: firstNamed + '/' + secondNamed,
  };
}

void main() {
  final positionalArg = 42;
  final namedArg1 = 'first named arg';
  final namedArg2 = 'second named arg';

  group('Memoize - basic functionality', () {
    test('one positional arg', () {
      final testFn = memoize(calculatePositional);
      final expectedValue = testFn(positionalArg);
      expect(testFn(positionalArg), equals(expectedValue));
    });

    test('positional and named args', () {
      final testFn = memoize(calculatePositionalAndNamed);
      final expectedValue = testFn(positionalArg, firstNamed: namedArg1, secondNamed: namedArg2);
      expect(testFn(positionalArg, firstNamed: namedArg1, secondNamed: namedArg2), equals(expectedValue));
    });

    test('named args in different order', () {
      final testFn = memoize(calculatePositionalAndNamed);
      final expectedValue = testFn(positionalArg, firstNamed: namedArg1, secondNamed: namedArg2);
      expect(testFn(positionalArg, secondNamed: namedArg2, firstNamed: namedArg1), equals(expectedValue));
    });
  });
}
