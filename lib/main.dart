import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Product {
  final String name;
  final double price;
  int count = 0;

  Product({required this.name, required this.price});
}

class MyApp extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Product 1', price: 10),
    Product(name: 'Product 2', price: 20),
    Product(name: 'Product 3', price: 30),
    Product(name: 'Product 4', price: 15),
    Product(name: 'Product 5', price: 25),
    Product(name: 'Product 6', price: 35),
    Product(name: 'Product 7', price: 12),
    Product(name: 'Product 8', price: 22),
    Product(name: 'Product 9', price: 32),
    Product(name: 'Product 10', price: 18),
    Product(name: 'Product 11', price: 28),
    Product(name: 'Product 12', price: 38),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Set this to false to remove the debug banner
      home: Scaffold(

        appBar: AppBar(
          centerTitle: true, // Center the title in the AppBar
          title: Text('Product List'),
        ),
        body: ProductList(products),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage(products)),
            );
          },
          child: Icon(Icons.shopping_cart),
          backgroundColor: Colors.blue,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked, // Place FAB at the bottom right
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;

  ProductList(this.products);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index].name),
          subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
          trailing: BuyButton(
            product: products[index],
            onBuy: (product) {
              if (product.count == 5) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Congratulations!'),
                      content: Text('You\'ve bought 5 ${product.name}!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}

class BuyButton extends StatelessWidget {
  final Product product;
  final Function(Product) onBuy;

  BuyButton({required this.product, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        product.count++;
        onBuy(product);
      },
      child: Text('Buy Now (${product.count})'),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage(this.products);

  @override
  Widget build(BuildContext context) {
    int totalProducts = products.fold(0, (sum, product) => sum + product.count);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Total Products in Cart: $totalProducts'),
      ),
    );
  }
}
