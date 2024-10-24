import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manual Driving Mode',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isButtonPressed = false;

  void sendCommand(List<int> command) async {
    try {
      final httpClient = HttpClient();
      final request = await httpClient.postUrl(
        Uri.parse('http://192.168.137.227:5000/control'),
      );
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode({'command': command}));
      final response = await request.close();
      print('Response: ${await response.transform(utf8.decoder).join()}');
    } catch (e) {
      print('Error connecting to the Flask server: $e');
    }
  }

  void sendRepeatedCommand(int startValue) async {
    int i = startValue;
    while (_isButtonPressed) {
      if (i < 128) {
        sendCommand([170, 2, 121, i, 121 + i]);
        i++;
      } else {
        sendCommand([170, 2, 121, 128, 249]);
      }
      await Future.delayed(Duration(milliseconds: 100));
    }
  }

  void sendRepeatedCommand1(int startValue) async {
    int i = startValue;
    while (_isButtonPressed) {
      if (i > 77) {
        sendCommand([170, 2, 121, i, 121 + i]);
        i--;
      } else {
        sendCommand([170, 2, 121, 77, 198]);
      }
      await Future.delayed(Duration(milliseconds: 100));
    }
  }
   void sendRepeatedCommand2(int startValue) async {
    int i = startValue;
    while (_isButtonPressed) {
      if (i < 125) {
        sendCommand([170, 2, 125, i, 125 + i]);
        i++;
      } else {
        sendCommand([170, 2, 125, 125, 250]);
      }
      await Future.delayed(Duration(milliseconds: 100));
    }
  }
  void sendRepeatedCommand3(int startValue) async {
    int i = startValue;
    while (_isButtonPressed) {
      if (i > 114) {
        sendCommand([170, 2, 125, i, 125 + i]);
        i--;
      } else {
        sendCommand([170, 2, 125, 114, 239]);
      }
      await Future.delayed(Duration(milliseconds: 100));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual Driving Mode'),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            child: VideoPlayerWidget(
              videoUrl: 'http://192.168.137.227:8084/?action=stream',
            ),
          ),
          SizedBox(height: 15),
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onLongPressStart: (_) {
                      setState(() {
                        _isButtonPressed = true;
                      });
                      sendRepeatedCommand(126);
                    },
                    onLongPressEnd: (_) {
                      setState(() {
                        _isButtonPressed = false;
                      });
                    },
                    child: FloatingActionButton(
                      onPressed: () {
                        sendCommand([170, 2, 121, 126, 247]);
                      },
                      backgroundColor: Color(0xFF83C89C),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_left, size: 30, color: Colors.white),
                          Text(
                            'Left',
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          sendCommand([170, 2, 125, 121, 246]);
                        },
                        backgroundColor: Color(0xFF83C89C),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_drop_up, size: 30, color: Colors.white),
                            Text(
                              'Forward',
                              style: TextStyle(fontSize: 11, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 150),
                      FloatingActionButton(
                        onPressed: () {
                          sendCommand([170, 2, 111, 121, 232]);
                        },
                        backgroundColor: Color(0xFF83C89C),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_drop_down, size: 30, color: Colors.white),
                            Text(
                              'Back',
                              style: TextStyle(fontSize: 11, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onLongPressStart: (_) {
                      setState(() {
                        _isButtonPressed = true;
                      });
                      sendRepeatedCommand1(97);
                    },
                    onLongPressEnd: (_) {
                      setState(() {
                        _isButtonPressed = false;
                      });
                    },
                    child: FloatingActionButton(
                      onPressed: () {
                        sendCommand([170, 2, 121, 97, 218]);
                      },
                      backgroundColor: Color(0xFF83C89C),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_right, size: 30, color: Colors.white),
                          Text(
                            'Right',
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
         Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    GestureDetector(
      onLongPressStart: (_) {
        setState(() {
          _isButtonPressed = true;
        });
        sendRepeatedCommand2(121); // Commande pour "Slight Left"
      },
      onLongPressEnd: (_) {
        setState(() {
          _isButtonPressed = false;
        });
      },
      child: ElevatedButton.icon(
        onPressed: () {
          sendCommand([170, 2, 125, 121, 146]); // Commande pour un appui simple "Slight Left"
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF83C89C)),
        ),
        icon: Icon(Icons.rotate_left, color: Colors.white),
        label: Text('Slight Left', style: TextStyle(color: Colors.white)),
      ),
    ),
    GestureDetector(
      onLongPressStart: (_) {
        setState(() {
          _isButtonPressed = true;
        });
        sendRepeatedCommand3(121); // Commande pour "Slight Right"
      },
      onLongPressEnd: (_) {
        setState(() {
          _isButtonPressed = false;
        });
      },
      child: ElevatedButton.icon(
        onPressed: () {
          sendCommand([170, 2, 125, 121, 246]); // Commande pour un appui simple "Slight Right"
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF83C89C)),
        ),
        icon: Icon(Icons.rotate_right, color: Colors.white),
        label: Text('Slight Right', style: TextStyle(color: Colors.white)),
      ),
    ),
  ],
),

          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                sendCommand([170, 2, 121, 121, 242]);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: Text('STOP', style: TextStyle(fontSize: 31, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: videoUrl,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
