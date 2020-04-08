class HandleErrorsManager {
  String catchNullInStringValue(var json) {
    if (json == null)
      return 'e';
    else
      return json as String;
  }

  double catchNullInDoubleValue(var json) {
    if (json == null)
      return -1;
    else
      return json * 100 / 100;
  }

  int catchNullInIntValue(var json) {
    if (json == null)
      return -1;
    else
      return json as int;
  }
}
