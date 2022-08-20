import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'settings.dart';
import 'MenuEntry.dart';

void main() {
  runApp(const POMLauncher());
}

/* class POMLauncherApp extends StatelessWidget {
  const POMLauncherApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peace of Mind Launcher',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.black,
        primaryTextTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: POMLauncher(),
    );
  }
} */

/* class POMSettings extends StatefulWidget {
  Settings settings;
  // BuildContext context;
  POMSettings({
    super.key,
    // required this.context,
    required this.settings,
  });

  @override
  State<POMSettings> createState() => _POMSettingsState();
}

class _POMSettingsState extends State<POMSettings> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity == 0) {
          return;
        }

        if (details.primaryVelocity?.compareTo(0) == -1) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
      ),
    );
  }
} */

class POMLauncher extends StatefulWidget {
  const POMLauncher({
    super.key,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<POMLauncher> createState() => _POMLauncherState();
}

class _POMLauncherState extends State<POMLauncher> {
  late Settings settings = Settings(
    primaryColor: Colors.red.value,
    primarySwatch: Colors.red.value,
    scaffoldBackgroundColor: Colors.black.value,
    textColor: Colors.white.value,
    buttonPosition: 'left',
  );

  bool _showMenu = false;

  // List<String> items = ['Alpha','Beta','Gamma'];

  List<MenuEntry> items = [
    MenuEntry(name: 'Alpha'),
    MenuEntry(name: 'Beta'),
    MenuEntry(name: 'Gamma'),
  ];

/*   GestureDetector showSettings(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity == 0) {
          return;
        }

        if (details.primaryVelocity?.compareTo(0) == -1) {
          Navigator.pop(context);
        }
      },
    );
  } */
  // @override
  // void initState(){
  //   db.initDatabase().then((value) async => {
  //     settings = await db.getSettings()
  //   }).then((value) => {
  //   super.initState()
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peace of Mind Launcher',
      theme: ThemeData(
        primaryColor: Color(settings.primaryColor),
        scaffoldBackgroundColor: Color(settings.scaffoldBackgroundColor),
        primarySwatch: Colors.red,
      ),
      home: SafeArea(
        child: GestureDetector(
          /* onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity == 0) {
              return;
            }

            if (details.primaryVelocity?.compareTo(0) != -1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => POMSettings(
                    settings: settings,
                  ),
                ),
              );
            }
          }, */
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Visibility(
                        visible: _showMenu,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: settings.buttonPosition == 'left'
                                ? Radius.circular(3)
                                : Radius.circular(30),
                            bottomRight: settings.buttonPosition == 'right'
                                ? Radius.circular(3)
                                : Radius.circular(30),
                          ),
                          child: ListView(
                            padding: EdgeInsets.all(0),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: items,
                          ),
                        ),
                      ),
                      Row(
                    children: [
                      GestureDetector(
                        child: Draggable<String>(
                          data: 'MenuEntry',
                          onDragStarted: () {
                            setState(() {
                              print('DragStart');
                              _showMenu = true;
                            });
                          },
                          onDragCompleted: () {
                            setState(() {
                              print('DragCompleted');
                              _showMenu = false;
                            });
                          },
                          onDragEnd: (details) {
                            setState(() {
                              print('DragEnd');
                              _showMenu = false;
                            });
                          },
                          onDraggableCanceled: (velocity, offset) {
                            setState(() {
                              print('DragCanceled');
                              _showMenu = false;
                            });
                          },
                          feedback: const SizedBox(
                            height: 1,
                            width: 1,
                            child: CircleAvatar(
                              backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                            ),
                          ),
                          child: Container(
                            height: _showMenu ? 0 : 50,
                            width: _showMenu ? 0 : 50,
                            child: FloatingActionButton(
                              backgroundColor: Color(settings.primaryColor),
                              onPressed: () {
                                for (var i in items) {
                                  print(i.name);
                                }
                                setState(() {
                                  print('Pressed');
                                  _showMenu = true;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
