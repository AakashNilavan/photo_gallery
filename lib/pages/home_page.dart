import 'package:flutter/material.dart';
import 'package:photo_gallery/pages/gallery.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  void _onTap(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? const Gallery()
          : const SafeArea(
              child: Center(
              child: Text("Coming Soon..."),
            )),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.code),
              label: 'In Development',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.code),
              label: 'In Development',
            ),
          ]),
    );
  }
}
