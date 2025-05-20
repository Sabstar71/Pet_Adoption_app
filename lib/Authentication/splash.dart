import "package:flutter/material.dart";

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loading Screen"),
      ),
      body: Center(
        child: Text("Loading...."),
      ),
    );
  }
}
