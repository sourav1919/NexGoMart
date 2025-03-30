import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:nexgomart/features/cart/domain/models/cart_item.dart';
import 'package:nexgomart/features/cart/ui/bloc/cart_bloc.dart';
import 'package:nexgomart/features/cart/ui/bloc/cart_event.dart';
import 'package:nexgomart/features/cart/ui/bloc/cart_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> bannerImages = [
    "assets/banner1.jpg",
    "assets/banner2.jpg",
    "assets/banner3.jpg",
    "assets/banner4.jpg",
  ];

  final List<Map<String, dynamic>> products = [
    {
      "id": "1",
      "name": "Chocolate Box",
      "price": 250.0,
      "image": "assets/placeholder.jpg",
    },
    {
      "id": "2",
      "name": "Teddy Bear",
      "price": 500.0,
      "image": "assets/placeholder.jpg",
    },
    {
      "id": "3",
      "name": "Jewelry Set",
      "price": 1200.0,
      "image": "assets/placeholder.jpg",
    },
    {
      "id": "4",
      "name": "Notebook Pack",
      "price": 200.0,
      "image": "assets/placeholder.jpg",
    },
    {
      "id": "5",
      "name": "Pen Set",
      "price": 150.0,
      "image": "assets/placeholder.jpg",
    },
    {
      "id": "6",
      "name": "Xerox & Printing",
      "price": 5.0,
      "image": "assets/placeholder.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NexGo Mart"),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int cartCount = state is CartUpdated ? state.items.length : 0;

              return Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () => context.go('/cart'),
                  ),
                  if (cartCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '$cartCount',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to NexGo Mart",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Banner Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 150.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items:
                  bannerImages.map((image) => _buildBannerItem(image)).toList(),
            ),
            SizedBox(height: 20),

            // Categories
            Text(
              "Categories",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryItem("Chocolates", Icons.cake, Colors.brown),
                  _buildCategoryItem("Teddy Bears", Icons.toys, Colors.pink),
                  _buildCategoryItem("Jewelry", Icons.diamond, Colors.orange),
                  _buildCategoryItem("Stationery", Icons.book, Colors.blue),
                  _buildCategoryItem(
                    "Xerox & Printing",
                    Icons.print,
                    Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Products
            Text(
              "Popular Products",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildProductGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerItem(String image) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
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

  Widget _buildProductGrid() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        List<CartItem> cartItems = state is CartUpdated ? state.items : [];
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            bool isInCart = cartItems.any((item) => item.id == product["id"]);
            return _buildProductItem(product, isInCart);
          },
        );
      },
    );
  }

  Widget _buildProductItem(Map<String, dynamic> product, bool isInCart) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                product["image"],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Text(
              product["name"],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("₹${product["price"]}", style: TextStyle(color: Colors.green)),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                final cartBloc = context.read<CartBloc>();
                isInCart
                    ? cartBloc.add(RemoveFromCart(product["id"]))
                    : cartBloc.add(
                      AddToCart(
                        CartItem(
                          id: product["id"],
                          name: product["name"],
                          price: product["price"],
                          quantity: 1,
                        ),
                      ),
                    );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isInCart ? Colors.red : Colors.green,
              ),
              child: Text(
                isInCart ? "Remove" : "Add to Cart",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
