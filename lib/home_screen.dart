import 'package:flutter/material.dart';
import 'package:flutter_animated_fab_menu/fab_menu_button.dart';

enum FabDisplay { vertical, horizontal, diagonal }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FabDisplay _fabDisplay = FabDisplay.vertical;

  _changeFabDisplay(FabDisplay display) {
    setState(() {
      _fabDisplay = display;
    });
  }

  @override
  Widget build(BuildContext context) {
    var displayOptions = [
      <String, dynamic>{'title': 'Vertical', 'display': FabDisplay.vertical},
      <String, dynamic>{'title': 'Horizontal', 'display': FabDisplay.horizontal},
      <String, dynamic>{'title': 'Diagonal', 'display': FabDisplay.diagonal},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated FAB menu"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: displayOptions.map((e) {
              var selectedColor =
                  e['display'] == _fabDisplay ? Theme.of(context).primaryColor : Colors.white;
              var bgColor =
                  e['display'] == _fabDisplay ? Colors.white : Theme.of(context).primaryColor;

              return SizedBox(
                width: 140,
                child: ElevatedButton(
                  onPressed: () => _changeFabDisplay(e['display']),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bgColor,
                    side: BorderSide(color: selectedColor),
                    elevation: 0,
                  ),
                  child: Text(
                    e['title'],
                    style: TextStyle(color: selectedColor),
                  ),
                ),
              );
            }).toList()),
      ),
      floatingActionButton: FabMenuButton(menuDisplay: _fabDisplay),
    );
  }
}
