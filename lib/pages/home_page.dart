import "package:flutter/material.dart";
// import "package:go_router/go_router.dart"; // or just Navigator
import "package:khookbook/pages/category_page.dart";
import "package:khookbook/pages/my_recipes_page.dart";
import "package:khookbook/pages/profile_page.dart";
import "package:khookbook/pages/settings_page.dart";

class HomePage extends StatefulWidget {
  static const String id = "home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  static const List<Widget> _pages = <Widget>[
    CategoryPage(title: "Categories"),
    MyRecipesPage(), // to be implemented
    ProfilePage(), // to be implemented
    SettingsPage(), // to be implemented
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
      // appBar: AppBar(), TODO: set `automaticallyImplyLeading` to the state of auth
      body: PageView(
        controller: _pageController,
        onPageChanged: (i) => setState(() => _selectedIndex = i),
        children: [_pages[_selectedIndex]],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark),
            label: "My Recipes",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          NavigationDestination(
            icon: Icon(Icons.menu),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
