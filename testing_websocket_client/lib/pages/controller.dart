import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing_websocket_client/main.dart';
import 'package:web_socket_channel/io.dart';
import 'package:joystick/joystick.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:web_socket_channel/status.dart' as status;
// import 'package:flutter/services.dart';

class Controller extends StatefulWidget {
  @override
  _ControllerState createState() => _ControllerState(); 
}



class _ControllerState extends State<Controller> {
  double _baseSlider = 0;
  double _lakatSlider = 0;
  double _gornjiZglob = 0;
  double _sliderKamera = 0;

  final _channel = IOWebSocketChannel.connect('ws://192.168.0.109:1258');
   

  late VlcPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();

    _videoPlayerController = VlcPlayerController.network(
      'http://192.168.0.109:9090/stream/video.mjpeg',
      autoPlay: true,
    );
  } 


@override 
Widget build(BuildContext context) {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);
    return Scaffold(
      
      // resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration (
          image: DecorationImage(
              image: AssetImage("images/kontrolerUI.jpg"),
              fit: BoxFit.cover,
            )
          ),
        child: Expanded(
          child: GridView.count(
          // padding: const EdgeInsets.symme,
          
          crossAxisCount: 3,
          
          children: [
        
            Padding(
              padding: const EdgeInsets.only(
                top: 60,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Ovde ide kontroler"),
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: Joystick(
                        
                        size: 150,
                        isDraggable: false,
                        backgroundColor: Colors.black,
                        opacity: .7,
                        joystickMode: JoystickModes.all,
                        onUpPressed: _moveForward,
                        onDownPressed: _moveBackward,
                        onLeftPressed: _moveLeft,
                        onRightPressed: _moveRight,
                        
                      ),
                    ),
                ],
              ),
            ),
        // decodeImageFromPixels(pixels, width, height, format, callback)
            
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Ovde ide kamera'),
                SizedBox(
                  
                  width: 220,
                  height: 100,
                  child: Center(
                    child: VlcPlayer(
                        controller: _videoPlayerController,
                        aspectRatio: 16/9,
                        placeholder: const Center(child: CircularProgressIndicator(backgroundColor: Color(0xff23278E)),),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(title: 'WebSocket Demo'),
                      ), 
                      
                    );
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                    ]);
                    _channel.sink.close(status.goingAway);
                    _channel.sink.add("stop");
                    
                  },
                  child: const Text("vrati nazad")
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 12.0,
                    // trackShape: RectangularSliderTrackShape(),
                  ),
                  child: Container(
                    width: 200,
                    height: 50,
                    child: Slider(
                      min: 0,
                      max: 120,
                      value: _sliderKamera,
                      onChanged: (value) {
                        setState(() {
                          _sliderKamera = value;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
            // const Text("Kandza ruke"),
            Padding(
              padding: const EdgeInsets.only(
                top: 18,
                left: 10,
                right: 3,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,            
                children:[
                  const Text("Kandza ruke"),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 12.0,
                    ),
                    child: Container(
                      width: 200,
                      // height: 100,
                      child: Slider(
                        value: _baseSlider,
                        min: 0,
                        max: 120,
                          // divisions: 5,
                        label: '${_baseSlider.round()}',
                        onChanged: (double value) {
                          setState(() {
                            _baseSlider = value;
                            _channel.sink.add("0" + _baseSlider.toString());
                          });
                        },
                      ),
                    ),
                  ),
                  // const Text("Kandza"),
                  
        
                  const Text("Lakat"),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 12,
                    ),
                    child: Container(
                      width: 200,
                      child: Slider(
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
                    ),
                  ),

                  const Text("Bazni servo 2"),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 12,
                    ),
                    child: Container(
                      width: 200,
                      child: Slider(
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
                    ),
                  ),
                  // const SizedBox(height: 30,),
                  const Text("Bazni servo 1"),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 12,
                    ),
                    child: Expanded(
                      child: Container(
                        width: 200,
                        child: Slider(
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
                      ),
                    ),
                  ),
                ],
                
              ),
            )
          ],
          
              ),
        ),
      ),
    );
  }

  Widget _control() => Padding(
    padding: const EdgeInsets.all(20.0),
    child: GridView.count(
      crossAxisCount: 3,
        children: [

        ],
      ),
  );

  void _moveForward() {
    _channel.sink.add("w");
  }

  void _moveBackward() {
    _channel.sink.add("s");
  }

  void _moveLeft() {
    _channel.sink.add("a");
  }

  void _moveRight() {
    _channel.sink.add("d");
  }
  

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
  }
}