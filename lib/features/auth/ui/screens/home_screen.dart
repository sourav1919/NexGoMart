import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nexgomart/features/auth/ui/bloc/auth_bloc.dart';
import 'package:nexgomart/features/auth/ui/bloc/auth_event.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> bannerImages = [
    "assets/banner3.jpg",
    "assets/banner2.jpg",
    "assets/banner1.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NexGo Mart"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hello!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Welcome to NexGo Mart", style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(height: 20),
              CarouselSlider(
                options: CarouselOptions(
                  height: 150.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
                items: bannerImages.map((image) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              // Featured Categories
              Text("Categories", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryItem("Fruits", Icons.apple, Colors.red),
                    _buildCategoryItem("Vegetables", Icons.eco, Colors.green),
                    _buildCategoryItem("Dairy", Icons.local_drink, Colors.blue),
                    _buildCategoryItem("Snacks", Icons.fastfood, Colors.orange),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Featured Products
              Text("Popular Products", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return _buildProductItem("Product $index", "₹${(index + 1) * 50}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, size: 30, color: color),
          ),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

Widget _buildProductItem(String name, String price) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Image.asset(
                  'assets/placeholder.jpg', // Replace with your local placeholder image path
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(price, style: TextStyle(color: Colors.green)),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
              child: Text("Add to Cart", style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

}
