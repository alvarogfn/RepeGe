import "package:flutter/material.dart";
import "package:repege/components/organism/custom_drawer.dart";


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RepeGe")),
      drawer: const CustomDrawer(),
    );
  }
}
