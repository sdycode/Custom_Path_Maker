  String getPainterStartingBody(String painterClassName) {
    return '''
class $painterClassName extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    double sw = s.width;
    double sh = s.height;
''';
  }