import 'package:flutter/material.dart';
import 'package:joystick/joystick.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'pages/controller.dart';
void main() async => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      home: Controller(
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
  double _baseSlider = 0;
  double _lakatSlider = 0;
  double _gornjiZglob = 0;
  double _sliderKamera = 0;
  double _kandzaRuke = 0;
  final TextEditingController _controller = TextEditingController();
  final _channel = IOWebSocketChannel.connect('ws://192.168.0.106:12346');

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(500, 20, 20, 20),
        
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            const Text("Servo osnove"),
              Slider(
              value: _baseSlider,
              min: 0,
              max: 180,
              // divisions: 5,
              label: '${_baseSlider.round()}',
              onChanged: (double value) {
                setState(() {
                  _baseSlider = value;
                  _channel.sink.add("0" + _baseSlider.toString());
                });
              },
            ),
            
            Text("Lakat"),
            Slider(
              min: 0,
              max: 180,
              value: _lakatSlider,
              onChanged: (double value) {
                setState(() {
                  _lakatSlider = value;
                  // _channel.sink.add("Drugi");
                  _channel.sink.add("1" + _lakatSlider.toString());
                });
              },
            ),
            Text("Gornji zglob"),
            Slider(
              min: 0,
              max: 180,
              value: _gornjiZglob,
              onChanged: (double value) {
                setState(() {
                  _gornjiZglob = value;
                  // _channel.sink.add("Drugi");
                  _channel.sink.add("2" + _gornjiZglob.toString());
                });
              },
            ),
            Text("Kamera"),
            Slider(
              min: 0,
              max: 180,
              value: _sliderKamera,
              onChanged: (double value) {
                setState(() {
                  _sliderKamera = value;
                  // _channel.sink.add("Drugi");
                  _channel.sink.add("3" + _sliderKamera.toString());
                });
              },
            ),

            const Text("servo kandze ruke"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 10),
                SizedBox(
                  height: 10,
                  width: 163,
                  child: Slider(
                    min: 0,
                    max: 180,
                    value: _kandzaRuke,
                    onChanged: (double value) {
                      setState(() {
                        _kandzaRuke = value;
                        // _channel.sink.add("Drugi");
                        _channel.sink.add("4" + _kandzaRuke.toString());
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            ),

            
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