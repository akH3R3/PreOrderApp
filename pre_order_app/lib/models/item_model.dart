import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String id;
  final String imageUrl;
  final String name;
  final String description;
  final double price;

  Item({required this.id, required this.imageUrl, required this.name, required this.description, required this.price});

  factory Item.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Item(
      id: doc.id,
      imageUrl: data['imageUrl'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price'].toDouble() ?? 0.0,
    );
  }
}
