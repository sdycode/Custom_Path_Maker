  String getPainterEndingBody(String painterClassName) {
    return '''
 }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
''';
  }