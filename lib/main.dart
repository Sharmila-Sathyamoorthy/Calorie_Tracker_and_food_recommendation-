import 'package:flutter/material.dart';
import 'package:dummy/SelectionScreen.dart';
import 'ImagePickerScreen.dart'; // Import the new screen

void main() {
  runApp(const CalorieTrackerApp());
}

class CalorieTrackerApp extends StatelessWidget {
  const CalorieTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          displayLarge: TextStyle(
              fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
          displayMedium: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var green = Colors.green[700];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthy Bites'),
        backgroundColor: Colors.green[800],
        elevation: 8.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[300]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Card(
                  elevation: 6.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Welcome User!',
                          style: Theme.of(context).textTheme.headline2,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.0),
                        Image.asset(
                          'assets/welcome_image.png', // Make sure to add an image in your assets
                          height: 150.0,
                          width: 150.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: newMethod(green),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectionScreen()),
                  );
                },
                child: const Text('Start Tracking'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue[700],
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ImagePickerScreen()),
                  );
                },
                child: const Text('Pick an Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color? newMethod(Color? green) => green;
}
