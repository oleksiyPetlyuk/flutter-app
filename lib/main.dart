import 'package:flutter/cupertino.dart';
import 'strings.dart';
import 'pages/HomePage.dart';

void main() => runApp(GHFlutterApp());

class GHFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: Strings.appTitle,
      home: HomePage(),
    );
  }
}
