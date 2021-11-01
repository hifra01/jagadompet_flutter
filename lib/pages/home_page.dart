import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jagadompet_flutter/pages/home_page_sections/history_section.dart';
import 'package:jagadompet_flutter/pages/home_page_sections/home_section.dart';
import 'package:jagadompet_flutter/pages/home_page_sections/profile_section.dart';
import 'package:jagadompet_flutter/widgets/app_bar_logo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? currentUser;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    currentUser = _auth.currentUser;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    }

    final List<Widget> _sectionsList = <Widget>[
      HomeSection(
        currentUser: currentUser,
      ),
      HistorySection(),
      HomeSection(
        currentUser: currentUser,
      ),
      ProfileSection(
        currentUser: currentUser,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const AppBarLogo(size: 18, color: Colors.white),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: _sectionsList,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Grafik',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
