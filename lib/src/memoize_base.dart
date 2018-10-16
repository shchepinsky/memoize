import 'dart:mirrors';

Map<String, Map<String, dynamic>> callsByFunction = Map();

_makeInvocationKey(Invocation invocation) {
  var positional = invocation.positionalArguments.fold('p', (acc, element) {
    return acc + ':' + element.hashCode.toString();
  });

  var named = invocation.namedArguments.entries.fold('n', (acc, entry) {
    final argName = MirrorSystem.getName(entry.key);
    final argValue = entry.value.hashCode.toString();
    return acc + ':$argName[$argValue]';
  });

  var invocationKey = positional + ':' + named;

  return invocationKey;
}

class _FunctionWrapper {
  final _fn;

  _FunctionWrapper(this._fn);

  @override
  dynamic noSuchMethod(Invocation invocation) {
    var argKey = _makeInvocationKey(invocation);
    var fnKey = _fn.hashCode.toString();
    var valuesByArgKey = callsByFunction[fnKey];
    var value;

    bool haveResultForArgs = valuesByArgKey != null && valuesByArgKey.containsKey(argKey);

    if (haveResultForArgs) {
      value = valuesByArgKey[argKey];
      return valuesByArgKey[argKey];
    }

    value = Function.apply(_fn, invocation.positionalArguments, invocation.namedArguments);

    if (valuesByArgKey == null) {
      valuesByArgKey = Map<String, dynamic>();
    }

    valuesByArgKey[argKey] = value;

    callsByFunction[fnKey] = valuesByArgKey;

    return value;
  }
}

memoize(Function fn) {
  return _FunctionWrapper(fn);
}
