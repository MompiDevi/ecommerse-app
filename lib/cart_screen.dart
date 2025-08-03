import 'package:ecommerse_app/checkout_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final List<CartItem> items = [
    CartItem(
      imageUrl: 'https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg',
      title: 'Embroidered Silk',
      size: 'M',
      color: 'Yellow Gold',
      price: 975,
      quantity: 1,
    ),
    CartItem(
      imageUrl: 'https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg',
      title: 'Anderson Bell',
      size: 'M',
      color: 'Gray',
      price: 750,
      quantity: 1,
    ),
    CartItem(
      imageUrl: 'https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg',
      title: 'Martine Rose',
      size: 'M',
      color: 'Blue',
      price: 345,
      quantity: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double subtotal = items.fold(0, (sum, item) => sum + (item.price * item.quantity));
    const double deliveryFee = 45.0;
    final double total = subtotal + deliveryFee;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Cart (${items.length.toString().padLeft(2, '0')})'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                return Dismissible(
                  key: ValueKey(item.title),
                  background: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) {
                    // Remove item logic
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              SizedBox(height: 4),
                              Text('Size: ${item.size}'),
                              Text('Color: ${item.color}'),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  _quantityButton(Icons.remove, () {}),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(item.quantity.toString().padLeft(2, '0')),
                                  ),
                                  _quantityButton(Icons.add, () {}),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\$${item.price.toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                _summaryRow('Sub-total', subtotal),
                _summaryRow('Delivery Fee', deliveryFee),
                Divider(),
                _summaryRow('Total Cost', total, isTotal: true),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(),));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Checkout'),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
        padding: EdgeInsets.all(4),
        child: Icon(icon, size: 16),
      ),
    );
  }
}

class CartItem {
  final String imageUrl;
  final String title;
  final String size;
  final String color;
  final double price;
  final int quantity;

  CartItem({
    required this.imageUrl,
    required this.title,
    required this.size,
    required this.color,
    required this.price,
    required this.quantity,
  });
}
