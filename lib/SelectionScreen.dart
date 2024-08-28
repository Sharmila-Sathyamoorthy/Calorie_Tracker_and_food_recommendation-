import 'package:flutter/material.dart';
import 'package:dummy/CalorieTrackerScreen.dart';
import 'package:dummy/RestaurantFoodsScreen.dart';

// Define custom colors
const Color primaryColor = Color(0xFF4CAF50); // Green
const Color accentColor = Color(0xFFFFC107); // Amber

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Food Type'),
        backgroundColor: primaryColor, // Use the primary color
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CalorieTrackerScreen()),
                  );
                },
                icon: const Icon(Icons.home, size: 24, color: accentColor), // Accent color for the icon
                label: const Text('Home Food'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // Use the primary color
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RestaurantFoodsScreen()),
                  );
                },
                icon: const Icon(Icons.restaurant_menu, size: 24, color: accentColor), // Accent color for the icon
                label: const Text('Restaurant Foods'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // Use the primary color
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
