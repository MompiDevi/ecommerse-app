import 'package:ecommerse_app/cart_screen.dart';
import 'package:ecommerse_app/details_screen.dart';
import 'package:flutter/material.dart';
import 'product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example static list
    final products = [
      {
        "image":
            "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg",
        "title": "Martine Rose",
        "price": "\$750.00",
        "rating": 4.6
      },
      {
        "image":
            "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg",
        "title": "Himalayan Hood",
        "price": "\$850.00",
        "rating": 4.8
      },
      {
        "image":
            "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg",
        "title": "Jumbo Canvas",
        "price": "\$550.00",
        "rating": 4.5
      },
      {
        "image":
            "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg",
        "title": "Gucci Jacket",
        "price": "\$900.00",
        "rating": 4.9
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('E-Shop'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.shopping_bag_outlined),
                IconButton(
                  icon: Icon(Icons.shopping_bag_outlined),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
                  },
                ),
                // Example cart count badge
                Positioned(
                  top: 6,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '3',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> p = products[index];
          return ProductCard(
            imageUrl: p['image'] ?? '',
            title: p['title']!,
            price: p['price']!,
            rating: p['rating']!,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(),));
            },
          );
        },
      ),
    );
  }
}
