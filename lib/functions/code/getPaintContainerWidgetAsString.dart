String getPaintContainerWidgetAsString(String painterClassName) {
    return '''

class MyPainterWidget extends StatelessWidget {
  const MyPainterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: 300,
        height: 300,
        child: CustomPaint(
          painter: ${painterClassName}(),
          size: Size(300, 300),
        ),
      );
  }
}    ''';
  }