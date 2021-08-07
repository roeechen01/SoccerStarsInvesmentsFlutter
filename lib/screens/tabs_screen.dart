import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soccer_stars_investments/main.dart';
import 'package:soccer_stars_investments/screens/buy_coins.dart';
import 'package:soccer_stars_investments/screens/my_assets_screen.dart';
import 'package:soccer_stars_investments/widgets/wev_view_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  int balance = 1000000;
  int screenIndex = 0;
  void moveScreen(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  void setBalance(int newBalance) {
    balance = newBalance;
  }

  List<Map<String, Object>> screens = [
    {'screen': MyHomePage(), 'title': MyHomePage().balancetitle()},
    {'screen': BuyCoinsScreen(), 'title': 'Buy coins'}
  ];

  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text('Click to view my Github'),
            IconButton(
                icon: Icon(Icons.web_sharp),
                onPressed: () {
                  _handleURLButtonPress(
                      context, 'https://github.com/roeechen01');
                })
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(
                Icons.business_center,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyAssetsScreen(MyHomePage.players),
                    ));
              },
            ),
          )
        ],
        title: Text(screens[screenIndex]['title']),
      ),
      body: screens[screenIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: moveScreen,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Invest'),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_outlined), label: 'Buy coins')
        ],
        currentIndex: screenIndex,
        //selectedItemColor: Colors.lightBlue,
        //unselectedItemColor: Colors.white,
      ),
    );
  }
}
