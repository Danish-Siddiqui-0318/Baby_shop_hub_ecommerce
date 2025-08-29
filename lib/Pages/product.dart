import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer( 
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(title: Text("Home")),
            ListTile(title: Text("Wishlist")),
            ListTile(title: Text("Orders")),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu, size: 28),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/logo.png", 
                        height: 32,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "Stylish",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage("assets/person.png"),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search any Product...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "52,082+ Items",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.sort, size: 18),
                        label: const Text("Sort"),
                      ),
                      const SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_list, size: 18),
                        label: const Text("Filter"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: demoProducts.length,
                itemBuilder: (context, index) {
                  final product = demoProducts[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(product["image"]!, fit: BoxFit.cover, width: double.infinity),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product["name"]!,
                                  style: const TextStyle(fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Text("₹${product["price"]}",
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star, size: 14, color: Colors.orange),
                                  const SizedBox(width: 2),
                                  Text("${product["rating"]} (${product["reviews"]})",
                                      style: const TextStyle(fontSize: 12, color: Colors.black54)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> demoProducts = [
  {
    "name": "Black Winter Jacket",
    "price": "499",
    "rating": "4.2",
    "reviews": "6,890",
    "image": "https://i.ibb.co/3WhJ9Bg/jacket.jpg",
  },
  {
    "name": "Mens Starry Shirt",
    "price": "399",
    "rating": "4.5",
    "reviews": "1,52,344",
    "image": "https://i.ibb.co/nm4frPW/shirt.jpg",
  },
  {
    "name": "Black Dress",
    "price": "2000",
    "rating": "4.4",
    "reviews": "5,23,456",
    "image": "https://i.ibb.co/wKrPQ9C/blackdress.jpg",
  },
  {
    "name": "Pink Embroidered Dress",
    "price": "1900",
    "rating": "4.3",
    "reviews": "45,678",
    "image": "https://i.ibb.co/QQGndLv/pinkdress.jpg",
  },
  {
    "name": "Black Dress",
    "price": "2000",
    "rating": "4.4",
    "reviews": "5,23,456",
    "image": "https://i.ibb.co/wKrPQ9C/blackdress.jpg",
  },
  {
    "name": "Pink Embroidered Dress",
    "price": "1900",
    "rating": "4.3",
    "reviews": "45,678",
    "image": "https://i.ibb.co/QQGndLv/pinkdress.jpg",
  },
  {
    "name": "Black Dress",
    "price": "2000",
    "rating": "4.4",
    "reviews": "5,23,456",
    "image": "https://i.ibb.co/wKrPQ9C/blackdress.jpg",
  },
  {
    "name": "Pink Embroidered Dress",
    "price": "1900",
    "rating": "4.3",
    "reviews": "45,678",
    "image": "https://i.ibb.co/QQGndLv/pinkdress.jpg",
  },
  {
    "name": "Black Dress",
    "price": "2000",
    "rating": "4.4",
    "reviews": "5,23,456",
    "image": "https://i.ibb.co/wKrPQ9C/blackdress.jpg",
  },
  {
    "name": "Pink Embroidered Dress",
    "price": "1900",
    "rating": "4.3",
    "reviews": "45,678",
    "image": "https://i.ibb.co/QQGndLv/pinkdress.jpg",
  },
  {
    "name": "Black Dress",
    "price": "2000",
    "rating": "4.4",
    "reviews": "5,23,456",
    "image": "https://i.ibb.co/wKrPQ9C/blackdress.jpg",
  },
  {
    "name": "Pink Embroidered Dress",
    "price": "1900",
    "rating": "4.3",
    "reviews": "45,678",
    "image": "https://i.ibb.co/QQGndLv/pinkdress.jpg",
  },
  {
    "name": "Black Dress",
    "price": "2000",
    "rating": "4.4",
    "reviews": "5,23,456",
    "image": "https://i.ibb.co/wKrPQ9C/blackdress.jpg",
  },
  {
    "name": "Pink Embroidered Dress",
    "price": "1900",
    "rating": "4.3",
    "reviews": "45,678",
    "image": "https://i.ibb.co/QQGndLv/pinkdress.jpg",
  },
  {
    "name": "Black Dress",
    "price": "2000",
    "rating": "4.4",
    "reviews": "5,23,456",
    "image": "https://i.ibb.co/wKrPQ9C/blackdress.jpg",
  },
  {
    "name": "Pink Embroidered Dress",
    "price": "1900",
    "rating": "4.3",
    "reviews": "45,678",
    "image": "https://i.ibb.co/QQGndLv/pinkdress.jpg",
  },
];
