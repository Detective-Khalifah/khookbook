import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart'; // or just Navigator
import 'package:khookbook/pages/category_page.dart';
import 'package:khookbook/pages/my_recipes_page.dart';
import 'package:khookbook/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  static const List<Widget> _pages = <Widget>[
    CategoryPage(title: 'Categories'),
    MyRecipesPage(), // to be implemented
    ProfilePage(), // to be implemented
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [_pages[_selectedIndex]],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark),
            label: 'My Recipes',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
