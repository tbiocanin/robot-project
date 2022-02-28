import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';


class Controller extends StatefulWidget {
  const Controller({Key ? key, required this.title}) : super(key : key);

  final String title;

  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
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
      // resizeToAvoidBottomInset: false,
      body: GridView.count(
        padding: const EdgeInsets.symmetric(),
        crossAxisCount: 3,
        
        children: [

          //TODO: ovde ce ici kontroler:


          Column(

            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
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

              const Text("Lakat"),
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
              const Text("Gornji zglob"),
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
              const Text("Kamera"),
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
            ],
            
          ),

          Column(
            //TODO: ovde ce ici kamera
            children: [
              
            ],
          )
        ],
        
      ),
    );
  }
}