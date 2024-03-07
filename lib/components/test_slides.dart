import 'package:flutter/material.dart';

class IntroSLides extends StatefulWidget {
  const IntroSLides({super.key});

  @override
  State<IntroSLides> createState() => _IntroSLidesState();
}

class _IntroSLidesState extends State<IntroSLides> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        PageView(
          controller: _pageController,
          children: [
            Container(
              color: Colors.red,
              child: const Center(
                child: Text('Page 1'),
              ),
            ),
            Container(
              color: Colors.green,
              child: const Center(
                child: Text('Page 2'),
              ),
            ),
            Container(
              color: Colors.blue,
              child: const Center(
                child: Text('Page 3'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
