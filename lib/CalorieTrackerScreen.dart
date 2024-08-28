import 'package:flutter/material.dart';

class FoodItem {
  final String name;
  final int quantity;
  final int calories;

  FoodItem({
    required this.name,
    required this.quantity,
    required this.calories,
  });
}

// Define custom colors
const Color primaryColor = Color(0xFF4CAF50); // Green
const Color accentColor = Color(0xFFFFC107); // Amber
const Color backgroundColor = Color(0xFFF5F5F5); // Light Grey
const Color containerBackgroundColor = Color(0xFFE8F5E9); // Light Green

class CalorieTrackerScreen extends StatefulWidget {
  const CalorieTrackerScreen({super.key});

  @override
  _CalorieTrackerScreenState createState() => _CalorieTrackerScreenState();
}

class _CalorieTrackerScreenState extends State<CalorieTrackerScreen> {
  List<FoodItem> foodItems = [];
  String? selectedFoodName;
  int selectedQuantity = 1;
  final List<String> foodNames = [
    'Idly', 'Rava Idly', 'Medium Dosa', 'Small Dosa', 'Masala Dosa',
    'Neer Dosa', 'Egg Dosa', 'Ragi Dosa', 'Poori', 'Parotta',
    'Chapati', 'Uttapam', 'Semiya Upma', 'Rava Upma', 'Milk',
    'Tea', 'Coffee', 'Boost', 'Horlicks', 'Soda',
    'Black Coffee', 'Milk Shake', 'Biriyani', 'Samabr Sadham',
    'Thayir Sadham', 'Bisi Bele Bath', 'Rasam', 'Pulisadham',
    'Lemon Sadham', 'Morkuzhambu', 'Egg Rice', 'Chicken Rice',
    'Chicken Noodles', 'Veg Noodles', 'Egg Noodles', 'Paneer Rice',
    'Kaarakuzhambu', 'Aviyal', 'Bread and Jam', 'Bread',
    'Bread with Butter', 'Vada', 'Bonda', 'Bajji', 'Samosa',
    'Payasam', 'Murukku', 'Banana Chips', 'Paniyaram', 'Jalebi',
    'Gulab Jamun', 'Pani Puri', 'Cutlet',
  ];

  @override
  void initState() {
    super.initState();
    selectedFoodName = foodNames[0];
  }

  void _addFoodItem() {
    if (selectedFoodName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a food item.'),
        ),
      );
      return;
    }

    int calories = _getCaloriesFromDatabase(selectedFoodName!);

    setState(() {
      foodItems.add(FoodItem(
        name: selectedFoodName!,
        quantity: selectedQuantity,
        calories: calories * selectedQuantity,
      ));
    });

    selectedFoodName = foodNames[0];
    selectedQuantity = 1;
  }

  int _getCaloriesFromDatabase(String foodName) {
    Map<String, int> database = {
      'idly': 135, 'rava idly': 68, 'medium dosa': 167, 'small dosa': 167,
      'masala dosa': 170, 'neer dosa': 80, 'egg dosa': 219, 'ragi dosa': 162,
      'poori': 296, 'parotta': 326, 'chapati': 300, 'uttapam': 145,
      'semiya upma': 164, 'rava upma': 200, 'milk': 109, 'tea': 70,
      'coffee': 140, 'boost': 240, 'horlicks': 190, 'soda': 10,
      'black coffee': 10, 'milk shake': 200, 'biriyani': 484,
      'samabr sadham': 216, 'thayir sadham': 50, 'bisi bele bath': 160,
      'rasam': 50, 'pulisadham': 226, 'lemon sadham': 221,
      'morkuzhambu': 153, 'egg rice': 240, 'chicken rice': 266,
      'chicken noodles': 290, 'veg noodles': 210, 'egg noodles': 221,
      'paneer rice': 210, 'kaarakuzhambu': 133, 'aviyal': 662,
      'bread and jam': 281, 'bread': 66, 'bread with butter': 281,
      'vada': 97, 'bonda': 68, 'bajji': 142, 'samosa': 250,
      'payasam': 408, 'murukku': 170, 'banana chips': 200,
      'paniyaram': 200, 'jalebi': 250, 'gulab jamun': 175,
      'pani puri': 125, 'cutlet': 75,
    };

    return database[foodName.toLowerCase()] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    int totalCalories = foodItems.fold(0, (sum, item) => sum + item.calories);
    int totalQuantity = foodItems.fold(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Tracker'),
        backgroundColor: primaryColor, // Use the primary color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  final foodItem = foodItems[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: Colors.white, // Light background color for the card
                    child: ListTile(
                      leading: const Icon(Icons.fastfood, color: primaryColor),
                      title: Text('${foodItem.name} x ${foodItem.quantity}'),
                      subtitle: Text('${foodItem.calories} calories'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            foodItems.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedFoodName,
                    onChanged: (newValue) {
                      setState(() {
                        selectedFoodName = newValue;
                      });
                    },
                    items: foodNames.map((String foodName) {
                      return DropdownMenuItem<String>(
                        value: foodName,
                        child: Text(foodName),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: 'Food',
                      labelStyle: TextStyle(color: primaryColor),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: selectedQuantity,
                    onChanged: (newValue) {
                      setState(() {
                        selectedQuantity = newValue!;
                      });
                    },
                    items: List.generate(10, (index) => index + 1)
                        .map((int quantity) {
                      return DropdownMenuItem<int>(
                        value: quantity,
                        child: Text(quantity.toString()),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: 'Quantity',
                      labelStyle: TextStyle(color: primaryColor),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _addFoodItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor, // Use the primary color
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: containerBackgroundColor, // Light background color
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Summary:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  const SizedBox(height: 8),
                  Text('Total Food Items: ${foodItems.length}'),
                  Text('Total Quantity: $totalQuantity'),
                  Text('Total Calories: $totalCalories'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
