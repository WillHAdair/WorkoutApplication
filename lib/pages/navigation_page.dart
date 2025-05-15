import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/pages/home_page.dart';
import 'package:workout_app/pages/workout_schedule_page.dart';
import 'package:workout_app/utils/themes.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 2;
  late PageController _pageController;
  bool _isAnimating = false;

  final List<String> _pageTitles = [
    'S C H E D U L E',
    'W O R K O U T',
    'H O M E',
    'F O O D',
    'S E T T I N G S',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 2);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageTitles[_currentIndex],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: themeProvider.getTextColor(),
          ),
        ),
        backgroundColor: themeProvider.getAppBarColor(),
        elevation: 2,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          if (!_isAnimating) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        children: [
          const WorkoutSchedulePage(), // History Page
          Container(color: Colors.green), // Workout Page
          const HomePage(),
          Container(color: Colors.yellow), // Food Page
          Container(color: Colors.purple), // Settings Page
        ],
      ),
      bottomNavigationBar: Container(
        color: themeProvider.navBarBackground,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GNav(
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                  _isAnimating = true;
                });
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ).then((_) {
                  setState(() {
                    _isAnimating = false;
                  });
                });
              },
              rippleColor: themeProvider.navBarHighlightBackground.withAlpha(77),
              hoverColor: themeProvider.navBarHighlightBackground.withAlpha(102),
              haptic: true,
              tabBorderRadius: 16,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              duration: const Duration(milliseconds: 300),
              gap: 8,
              color: themeProvider.navBarText,
              activeColor: themeProvider.navBarText,
              tabBackgroundColor: themeProvider.navBarHighlightBackground.withAlpha(128),
              tabs: const [
                GButton(icon: Icons.calendar_month, text: 'Plan'),
                GButton(icon: Icons.fitness_center_rounded, text: 'Workout'),
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.restaurant, text: 'Food'),
                GButton(icon: Icons.settings, text: 'Settings'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
