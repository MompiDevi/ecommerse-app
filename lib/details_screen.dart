import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailsScreen extends StatelessWidget {
  final String imageUrl =
      'https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIconButton(Icons.arrow_back, () {
                      Navigator.pop(context);
                    }),
                    Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    _buildIconButton(Icons.shopping_bag_outlined, () {}),
                  ],
                ),
              ),
          
              // Main image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              '4.5',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          
              ProductDetailsBottom()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(String url, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.all(isSelected ? 2 : 0),
      decoration: BoxDecoration(
        border: isSelected
            ? Border.all(color: Colors.black, width: 2)
            : Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}



class ProductDetailsBottom extends StatefulWidget {
  const ProductDetailsBottom({Key? key}) : super(key: key);

  @override
  State<ProductDetailsBottom> createState() => _ProductDetailsBottomState();
}

class _ProductDetailsBottomState extends State<ProductDetailsBottom> {
  int quantity = 1;
  int selectedColor = 0;
  int selectedSize = 1;
  bool showFullDescription = false;

  final List<Color> colors = [
    Color(0xFFD4C4B2),
    Color(0xFF49626D),
    Color(0xFFC5C3C1),
    Color(0xFF9C9B9B),
  ];

  final List<String> sizes = ["S", "M", "L", "XL", "XXL"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Quantity
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "DG Embroidered Silk Shirt",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        quantity.toString().padLeft(2, "0"),
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Price
            const Text(
              "From: \$975.00",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            // Colors
            Row(
              children: List.generate(colors.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedColor == index
                            ? Colors.amber
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: colors[index],
                      radius: 14,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            // Sizes
            const Text(
              "Size",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(sizes.length, (index) {
                  final isSelected = selectedSize == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSize = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.amber : Colors.transparent,
                        border: Border.all(
                          color:
                              isSelected ? Colors.amber : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        sizes[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            // Description
            const Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text.rich(
              TextSpan(
                text: showFullDescription
                    ? "Crafted with premium materials, these cargo pants seamlessly blend contemporary style and luxurious comfort."
                    : "Crafted with premium materials, these cargo pants seamlessly blend contem...",
                children: [
                  TextSpan(
                    text: showFullDescription ? " Read less" : " Read more",
                    style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  showFullDescription = !showFullDescription;
                });
              },
              child: const SizedBox(height: 24),
            ),
            const SizedBox(height: 16),
            // Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                    
               onPressed: () {},
               style: ElevatedButton.styleFrom(
                 elevation: 0,
                 backgroundColor: Colors.amber,
                 foregroundColor: Colors.black,
                 padding: const EdgeInsets.symmetric(vertical: 16),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(28),
                 ),
               ),
               child: const Text("Add to Cart"),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
