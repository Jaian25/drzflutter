import 'package:flutter/material.dart';
import 'favourites_page.dart';
import 'tests_page.dart';
import 'history_page.dart';
import '../../models/user.dart' as db_user;
import '../../services/firebase_auth_service.dart';
import '../../views/loginPanel/login_screen.dart';
// import '../views/settings_page.dart';

class HomeScreen extends StatefulWidget {
  final db_user.User? currentUser; // Nullable user

  const HomeScreen({Key? key, this.currentUser}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _logout() async {
    await FirebaseAuthService().signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSidebar(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 121, 70, 216),
        title: const Center(child: Text("D R.  Z E D")),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTabItem(Icons.favorite, 0),
              _buildTabItem(Icons.science, 1),
              _buildTabItem(Icons.history, 2),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          FavoritesPage(),
          TestsPage(),
          HistoryPage(),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 121, 70, 216),
            ),
            accountName: Text(widget.currentUser != null ? widget.currentUser!.name : "Guest User"),
            accountEmail: Text(widget.currentUser != null && widget.currentUser!.bio.isNotEmpty
                ? widget.currentUser!.bio
                : "No bio available"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: widget.currentUser != null && widget.currentUser!.profileUri.isNotEmpty
                  ? NetworkImage(widget.currentUser!.profileUri)
                  : const AssetImage('assets/images/default_user.png') as ImageProvider,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => SettingsPage()),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Log Out"),
            onTap: _logout,
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _currentIndex == index ? Colors.white.withOpacity(0.2) : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: _currentIndex == index ? Colors.white : Colors.grey,
          size: 30,
        ),
      ),
    );
  }
}
