// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:preppa/widgets/startup_names.dart';
import 'package:http/http.dart';


void main() {
  runApp(const PreppaApp());
}

class PreppaApp extends StatefulWidget {
  const PreppaApp({super.key});

  @override
  State<PreppaApp> createState() => _PreppaAppState();
}

class _PreppaAppState extends State<PreppaApp> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Preppa Meal Assistant",
        home: Scaffold(
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
          },
          selectedIndex: currentPageIndex,
          destinations: const<Widget>[
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'My week',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              label: 'Cupboard search',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.person),
              label: 'Settings',
            )
          ],
        ),
        body: <Widget> [
        RandomWords(),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        )
      ][currentPageIndex]
    )
    );
  }
}