import 'package:flutter/material.dart';

class MenuEntry extends StatefulWidget {
  final String name;
  final double height = 40;
  bool _hovering = false;
  MenuEntry({
    super.key,
    required this.name,
  });

  @override
  // ignore: no_logic_in_create_state
  State<MenuEntry> createState() => _MenuEntryState();

  // PopupMenuItem toPopupMenuItem() {
  //   return PopupMenuItem(
  //     child: this,
  //     value: name,
  //   );
  // }
}

class _MenuEntryState extends State<MenuEntry> {
  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return Container(
          color: widget._hovering ? Colors.red[800] : Colors.red,
          height: widget.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: widget._hovering
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      },
      onWillAccept: (data) {
        setState(() {
          widget._hovering = true;
        });
        return "MenuEntry" == data;
      },
      onAccept: (data) {
        print('Drag accepted: ${widget.name}');
        setState(() {
          widget._hovering = false;
        });
      },
      onLeave: (data) {
        setState(() {
          widget._hovering = false;
        });
      },
    );
  }
}
