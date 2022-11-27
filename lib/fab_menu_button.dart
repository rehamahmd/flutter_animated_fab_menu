import 'package:flutter/material.dart';
import 'package:flutter_animated_fab_menu/home_screen.dart';

double buttonSize = 56;

class FabMenuButton extends StatefulWidget {
  final FabDisplay menuDisplay;
  const FabMenuButton({super.key, required this.menuDisplay});

  @override
  State<FabMenuButton> createState() => _FabMenuButtonState();
}

class _FabMenuButtonState extends State<FabMenuButton> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return FloatingActionButton(onPressed: () {});
    return Flow(
      clipBehavior: Clip.hardEdge,
      delegate: FabVerticalDelegate(
        controller: animationController,
        menuDisplay: widget.menuDisplay,
      ),
      children: <IconData>[Icons.menu, Icons.search, Icons.save, Icons.download]
          .map((e) => _buildItem(e))
          .toList(),
    );
  }

  Widget _buildItem(IconData icon) => SizedBox(
        height: buttonSize,
        width: buttonSize,
        child: FloatingActionButton(
          elevation: 0.0,
          onPressed: () {
            if (animationController.status == AnimationStatus.completed) {
              animationController.reverse();
              return;
            }
            animationController.forward();
          },
          child: Icon(icon),
        ),
      );
}

class FabVerticalDelegate extends FlowDelegate {
  final Animation<double> controller;
  final menuDisplay;
  FabVerticalDelegate({required this.controller, required this.menuDisplay})
      : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    var lastFabIndex = context.childCount - 1;
    var size = context.size;
    final xStart = size.width - buttonSize;
    final yStart = size.height - buttonSize;
    const margin = 8;

    for (int i = lastFabIndex; i >= 0; i--) {
      final childSize = context.getChildSize(i)?.width;

      final dx = (childSize! + margin) * i;
      var x = xStart;
      var y = yStart - dx * controller.value;
      switch (menuDisplay) {
        case FabDisplay.horizontal:
          x = xStart - dx * controller.value;
          y = yStart;
          break;
        case FabDisplay.diagonal:
          x = xStart - dx * .7 * controller.value;
          y = yStart - dx * .7 * controller.value;
          break;
        default:
      }

      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
