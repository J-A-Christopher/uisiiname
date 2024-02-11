import 'package:flutter/material.dart';
import 'package:usiiname/components/chat.dart';
import 'package:usiiname/components/random_recipe.dart';
import 'package:usiiname/components/your_donation_component.dart';

class BottomNavgBar extends StatefulWidget {
  const BottomNavgBar({super.key});

  @override
  State<BottomNavgBar> createState() => _BottomNavgBarState();
}

class _BottomNavgBarState extends State<BottomNavgBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const YourDonationsWrapper(),
    const ChartComponent(),
    const RandomRec()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color(0xff5BDDCD),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.volunteer_activism), label: 'Donations'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(Icons.ramen_dining), label: 'Recipe'),
          ]),
      body: _pages.elementAt(_selectedIndex),
    );
  }
}
