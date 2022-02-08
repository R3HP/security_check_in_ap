class MyFailure {
  final String message;

  MyFailure({
    required this.message,
  });

  @override
  String toString() {
    return message;
  }

}
