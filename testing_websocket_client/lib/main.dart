import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/status.dart' as status;
void main() async => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
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
  double _currentSliderValue = 0;
  double _currentSliderValue2 = 0;
  double _gornjiZglob = 0;
  double _donjiZglob = 0;
  double _kandzaRuke = 0;
  final TextEditingController _controller = TextEditingController();
  final _channel = IOWebSocketChannel.connect('ws://192.168.0.106:12346');

  
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
            Text("Servo motor kamere"),
            Slider(
              value: _currentSliderValue,
              min: 0,
              max: 180,
              // divisions: 5,
              label: '${_currentSliderValue.round()}',
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                  _channel.sink.add("0" + _currentSliderValue.toString());
                });
              },
            ),
            Text("Servo motor gornjeg zgloba ruke"),
            Slider(
              min: 0,
              max: 180,
              value: _gornjiZglob,
              onChanged: (double value) {
                setState(() {
                  _gornjiZglob = value;
                  // _channel.sink.add("Drugi");
                  _channel.sink.add("1" + _gornjiZglob.toString());
                });
              },
            ),
            Text("Servo motor donjeg ruke"),
            Slider(
              min: 0,
              max: 180,
              value: _donjiZglob,
              onChanged: (double value) {
                setState(() {
                  _donjiZglob = value;
                  // _channel.sink.add("Drugi");
                  _channel.sink.add("2" + _donjiZglob.toString());
                });
              },
            ),
            Text("Servo motor kandza ruke"),
            Slider(
              min: 0,
              max: 180,
              value: _currentSliderValue2,
              onChanged: (double value) {
                setState(() {
                  _kandzaRuke = value;
                  // _channel.sink.add("Drugi");
                  // _channel.sink.add("3" + _currentSliderValue2.toString());
                });
              },
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}