import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: CartScreen(),
    );
  }
}

class CartItem {
  String name;
  String color;
  String size;
  int quantity;
  double price;

  CartItem({
    required this.name,
    required this.color,
    required this.size,
    required this.quantity,
    required this.price,
  });
}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem(name: 'Pullover', color: 'Black', size: 'L', quantity: 1, price: 51),
    CartItem(name: 'T-Shirt', color: 'Gray', size: 'L', quantity: 1, price: 30),
    CartItem(name: 'Sport Dress', color: 'Black', size: 'M', quantity: 1, price: 43),
  ];

  double get totalAmount {
    return cartItems.fold(0, (sum, item) => sum + (item.quantity * item.price));
  }

  void _incrementQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      }
    });
  }

  void _checkout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Congratulations! Your order has been placed.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bag'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/${item.name.toLowerCase().replaceAll(' ', '_')}.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.name),
                    subtitle: Text('Color: ${item.color} | Size: ${item.size}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => _decrementQuantity(index),
                        ),
                        Text(item.quantity.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _incrementQuantity(index),
                        ),
                        const SizedBox(width: 10),
                        Text('${item.price * item.quantity}\$'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Text(
                      'Total amount:',
                      style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w300),
                    ),
                    const Spacer(),
                    Text(
                      '${totalAmount.toStringAsFixed(2)}\$',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _checkout,
                  child: Text('CHECK OUT'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
