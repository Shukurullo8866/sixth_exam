import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmsPage extends StatelessWidget {
  const SmsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sms"),
      ),
      body: Container(
        color: CupertinoColors.systemIndigo,
      ),
    );
  }
}
