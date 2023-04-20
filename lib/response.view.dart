import 'dart:async';

import 'package:flutter/material.dart';

class MyStatefulWidget extends StatefulWidget {
  final String response;
  final String query;

  const MyStatefulWidget(
      {Key? key, required this.response, required this.query})
      : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late Timer timer;
  final List<Widget> widgets = [];
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    items = preprocess(widget.response);
    int ticks = 0;

    timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      setState(() {
        if (ticks >= items.length) {
          timer.cancel();
        } else {
          // Show ranking in reverse order. From 10 to 1.
          widgets.add(buildRow(items[items.length - (widgets.length + 1)]));
          ticks += 1;
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  List<String> preprocess(String data) {
    return data.split('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(widget.query),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6098F9),
              Color(0xFF506CE7),
              Color(0xFF2D2E72),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                  itemCount: widgets.length,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return widgets[index];
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(String name) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
