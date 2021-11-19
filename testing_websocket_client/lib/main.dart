import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
        // _channel: IOWebSocketChannel.connect('ws://192.168.16.126:1234'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _currentSliderValue = 20;
  final channel = IOWebSocketChannel.connect('ws://192.168.0.106:12345');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Slider(
              value: _currentSliderValue,
              min: 0,
              max: 180,
              // divisions: 5,
              label: '${_currentSliderValue.round()}',
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
            // StreamBuilder(
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     return Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Container(
            //         child: Text(snapshot.hasData ? '${snapshot.data}' : ' '),
            //       ),
            //     );
            //   }
            //   ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    // if (_controller.text.isNotEmpty) {
      // var _channel;
    channel.sink.add(_currentSliderValue);
    print(_currentSliderValue);
    // }
  }

  // @override
  // void dispose() {
  //   channel.sink.close();
  //   super.dispose();
  // }
}