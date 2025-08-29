import 'package:baby_shop_hub/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: OwnAppBar(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            Row(
              children: const [
                Icon(Icons.location_on_outlined, color: Colors.black87),
                SizedBox(width: 6),
                Text(
                  "Delivery Address",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Text(
                      "Address :\n216 St Paul’s Rd, London N1 2LL, UK\nContact : +44-784232",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Icon(Icons.add, color: Colors.black),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Shopping List
            const Text(
              "Shopping List",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Product card 1
            ProductCard(
              imageUrl:
                  "https://images.pexels.com/photos/428364/pexels-photo-428364.jpeg",
              title: "Women's Casual Wear",
              variations: ["Black", "Red"],
              rating: 4.8,
              price: 34,
              oldPrice: 64,
              discount: "upto 33% off",
            ),

            const SizedBox(height: 12),

            // Product card 2
            ProductCard(
              imageUrl:
                  "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
              title: "Men’s Jacket",
              variations: ["Green", "Grey"],
              rating: 4.7,
              price: 45,
              oldPrice: 67,
              discount: "upto 28% off",
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final List<String> variations;
  final double rating;
  final double price;
  final double oldPrice;
  final String discount;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.variations,
    required this.rating,
    required this.price,
    required this.oldPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Product image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Image.network(
                  imageUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),

              // Product details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Variations : ${variations.join(", ")}",
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black54),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              size: 16, color: Colors.orange),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: const TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "\$$price.00",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "\$$oldPrice.00",
                            style: const TextStyle(
                              fontSize: 13,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            discount,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
            
          ),
          

          const Divider(height: 1),

          // Total row with + -
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left: Total Order
                Text("Total Order (1) :",
                    style: TextStyle(color: Colors.grey.shade700)),

                // Right: Price + buttons
                Row(
                  children: [
                    const Icon(Icons.remove_circle_outline,
                        color: Colors.black54),
                    const SizedBox(width: 6),
                    Text("\$$price.00",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(width: 6),
                    const Icon(Icons.add_circle_outline,
                        color: Colors.black54),
                  ],
                ),
              ],
            ),
          ),
          
        ],
        
      ),
      
    );
  }
}
