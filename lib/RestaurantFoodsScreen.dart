import 'package:flutter/material.dart';

class FoodItem {
  final String name;
  final int quantity;
  final int calories;
  final String category;

  FoodItem({
    required this.name,
    required this.quantity,
    required this.calories,
    required this.category,
  });
}

// Define custom colors
const Color primaryColor = Color(0xFF4CAF50); // Green
const Color accentColor = Color(0xFFFFC107); // Amber
const Color backgroundColor = Color(0xFFF5F5F5); // Light Grey
const Color containerBackgroundColor = Color(0xFFE8F5E9); // Light Green

class RestaurantFoodsScreen extends StatefulWidget {
  const RestaurantFoodsScreen({super.key});

  @override
  _RestaurantFoodsScreenState createState() => _RestaurantFoodsScreenState();
}

class _RestaurantFoodsScreenState extends State<RestaurantFoodsScreen> {
  List<FoodItem> foodItems = [];
  String? selectedFoodName;
  int selectedQuantity = 1;
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'South Indian',
    'North Indian',
    'Chinese',
  ];

  final Map<String, String> foodCategories = {
    // South Indian
    'Idly': 'South Indian',
    'Pongal': 'South Indian',
    'Vada': 'South Indian',
    'Idly Vadai': 'South Indian',
    'Pongal Vadai': 'South Indian',
    'Mini Tiffin': 'South Indian',
    'South Indian Rush Lunch': 'South Indian',
    'South Indian Thali': 'South Indian',

    // North Indian
    'Chapati': 'North Indian',
    'Parotta': 'South Indian',
    'Poori': 'North Indian',
    'Pani Puri (6 Pcs)': 'North Indian',
    'Chenna Masala': 'North Indian',
    'Aloo Puri': 'North Indian',
    'Dahi Samosa': 'North Indian',
    'Dahi Kachori': 'North Indian',
    'Aloo Chat': 'North Indian',
    'Sev Puri': 'North Indian',
    'Jain Bhel Puri': 'North Indian',
    'Jain Pani Puri': 'North Indian',
    'Masala Puri': 'North Indian',
    'Chola Samosa': 'North Indian',
    'Dahi Puri': 'North Indian',
    'Dahi Vada': 'North Indian',
    'Jalmodi': 'North Indian',
    'Chola Cutlet': 'North Indian',
    'Chola Kachori': 'North Indian',
    'Dahi Bhalla': 'North Indian',
    'Dahi Papdi Chat': 'North Indian',
    'Bhel Puri': 'North Indian',
    'Katori Chat': 'North Indian',
    'Rajkachori': 'North Indian',
    'Tokari Chat': 'North Indian',

    // Chinese
    'Spring Roll': 'Chinese',
    'Hakka Noodles': 'Chinese',
    'Fried Rice': 'Chinese',
    'Manchurian': 'Chinese',
    'Hot & Sour Soup': 'Chinese',
    'Dim Sum': 'Chinese',
    'Chow Mein': 'Chinese',
    'Sweet and Sour Chicken': 'Chinese',
    'Kung Pao Chicken': 'Chinese',
    'Szechuan Noodles': 'Chinese',
    'Beef with Broccoli': 'Chinese',
    'General Tso\'s Chicken': 'Chinese',
    'Egg Drop Soup': 'Chinese',
  };

  final Map<String, int> foodCalories = {
    // South Indian
    'Idly': 320,
    'Pongal': 429,
    'Vada': 103,
    'Idly Vadai': 414,
    'Pongal Vadai': 631,
    'Mini Tiffin': 1036,
    'South Indian Rush Lunch': 1202,
    'South Indian Thali': 1913,

    // North Indian
    'Chapati': 556,
    'Parotta': 622,
    'Poori': 512,
    'Pani Puri (6 Pcs)': 150,
    'Chenna Masala': 250,
    'Aloo Puri': 300,
    'Dahi Samosa': 200,
    'Dahi Kachori': 220,
    'Aloo Chat': 180,
    'Sev Puri': 190,
    'Jain Bhel Puri': 160,
    'Jain Pani Puri': 150,
    'Masala Puri': 230,
    'Chola Samosa': 240,
    'Dahi Puri': 210,
    'Dahi Vada': 200,
    'Jalmodi': 190,
    'Chola Cutlet': 230,
    'Chola Kachori': 220,
    'Dahi Bhalla': 210,
    'Dahi Papdi Chat': 200,
    'Bhel Puri': 180,
    'Katori Chat': 250,
    'Rajkachori': 270,
    'Tokari Chat': 260,

    // Chinese
    'Spring Roll': 180,
    'Hakka Noodles': 350,
    'Fried Rice': 400,
    'Manchurian': 300,
    'Hot & Sour Soup': 120,
    'Dim Sum': 150,
    'Chow Mein': 450,
    'Sweet and Sour Chicken': 250,
    'Kung Pao Chicken': 290,
    'Szechuan Noodles': 380,
    'Beef with Broccoli': 300,
    'General Tso\'s Chicken': 300,
    'Egg Drop Soup': 80,
  };

  @override
  void initState() {
    super.initState();
    selectedFoodName = foodNamesByCategory('All').first;
  }

  List<String> foodNamesByCategory(String category) {
    if (category == 'All') {
      return foodCategories.keys.toList();
    } else {
      return foodCategories.entries
          .where((entry) => entry.value == category)
          .map((entry) => entry.key)
          .toList();
    }
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

    int calories = foodCalories[selectedFoodName!] ?? 0;
    String category = foodCategories[selectedFoodName!] ?? 'Unknown';

    setState(() {
      foodItems.add(FoodItem(
        name: selectedFoodName!,
        quantity: selectedQuantity,
        calories: calories * selectedQuantity,
        category: category,
      ));
    });

    selectedFoodName = foodNamesByCategory(selectedCategory).first;
    selectedQuantity = 1;
  }

  void _removeFoodItem(int index) {
    setState(() {
      foodItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<FoodItem> filteredFoodItems = foodItems;

    int totalCalories =
        filteredFoodItems.fold(0, (sum, item) => sum + item.calories);
    int totalQuantity =
        filteredFoodItems.fold(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Foods'),
        backgroundColor: primaryColor, // Use the primary color
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedCategory,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                          selectedFoodName =
                              foodNamesByCategory(newValue).first;
                        });
                      },
                      items: categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        labelText: 'Category',
                        labelStyle: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          value: selectedFoodName,
                          onChanged: (newValue) {
                            setState(() {
                              selectedFoodName = newValue;
                            });
                          },
                          items: foodNamesByCategory(selectedCategory)
                              .map((String foodName) {
                            return DropdownMenuItem<String>(
                              value: foodName,
                              child: Text(foodName),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: 'Food',
                            labelStyle: TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Flexible(
                        flex: 1,
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
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: 'Quantity',
                            labelStyle: TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addFoodItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor, // Use the primary color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Add Food'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: containerBackgroundColor, // Light background color
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Calories Consumed',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '$totalCalories Calories',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '$totalQuantity Items',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              filteredFoodItems.isEmpty
                  ? const Text('No food items added yet.')
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredFoodItems.length,
                      itemBuilder: (context, index) {
                        final foodItem = filteredFoodItems[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            title:
                                Text('${foodItem.name} x${foodItem.quantity}'),
                            subtitle: Text('${foodItem.calories} Calories'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _removeFoodItem(index);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
