import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var navigationState = Provider.of<NavigationState>(context);

    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/students');
            } else if (index == 1) {
              Navigator.pushReplacementNamed(context, '/teacher');
            }
          },
          backgroundColor: Colors.white,
          color: Colors.purple,
          items: [
            Icon(
              Icons.settings,
              color: Colors.white,
            ),
            Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            Icon(
              Icons.home,
              color: Colors.white,
            ),
          ],
          index: navigationState.selectedIndex,
        ),
        body: Container(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  child: Container(
                alignment: Alignment.center,
                width: size.width,
                height: 30,
                color: const Color.fromARGB(255, 2, 107, 5),
                child: Text("Name to be entered here:"),
              ))
            ],
          ),
        ));
  }
}
