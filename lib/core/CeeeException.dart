class CeeeException implements Exception{
  var msg;

  CeeeException(var this.msg);

  @override
  String toString() {
    return msg;
  }

}