import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/controller.dart';
void main() async => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {

    
    const title = 'WebSocket Demo';
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
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

String inputString = "";

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      body: Container(
        // child: DecoratedBox(
        decoration: const BoxDecoration (
          image: DecorationImage(
              image: AssetImage("images/backGroundUI.jpg"),
              fit: BoxFit.cover,
            )
          ),
        child: Center(
          child: _connection(),
        ),
      // ),
      )
    );
  }

  Widget _connection() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Uneti IP:port kontrolera",
              style: TextStyle(height: 5, fontSize: 18, color: Color(0xff23278E), fontStyle: FontStyle.italic),
            
            ),
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: "IP:PORT kontrolera",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff23278E))
                )
              ),
              
            ),
            ElevatedButton(
              
              onPressed: () {
                //go to the controller page
                // setState(() {
                  if(textController.text == '192.168.0.106:1246') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: ((context) => Controller()))
                    );

                    // SystemChrome.setPreferredOrientations([
                    //   DeviceOrientation.landscapeLeft,
                    // ]);
                  } else {
                    textController.text = 'Greska';
                  }
                // });
                
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )
              ),
              // padding: EdgeInsets.all(0.0),
              child: Ink(
                // padding: EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff23278E), Color(0xff8F01FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,                  
                  ),
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 150.0, minHeight: 40.0),
                  alignment: Alignment.center,
                  child: const Text("Povezi se"),
                ),
              ), 
            )              
            
          ],
        ),
  );

  Widget _colourGradient() => Ink(
    decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff23278E), Color(0xff8F01FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,                  
                  ),
    )
  );
}