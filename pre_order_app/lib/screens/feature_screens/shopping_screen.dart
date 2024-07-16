import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pre_order_app/models/item_model.dart';
import 'package:pre_order_app/widgets/my_appbar.dart';

class ShoppingScreen extends StatefulWidget {
  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    QuerySnapshot snapshot = await _firestore.collection('items').get();
    setState(() {
      _items = snapshot.docs.map((doc) => Item.fromFirestore(doc)).toList();
    });
  }

  void _addToPreorder(Item item) async {
    // Check if the item already exists in the preorders collection
    QuerySnapshot existingPreorders = await _firestore
        .collection('preorders')
        .where('itemId', isEqualTo: item.id)
        .get();

    if (existingPreorders.docs.isEmpty) {
      // If the item does not exist, add it to preorders
      await _firestore.collection('preorders').add({
        'itemId': item.id,
        'name': item.name,
        'description': item.description,
        'imageUrl': item.imageUrl,
        'price': item.price,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.name} added to preorders!'),
          backgroundColor: Colors.pink,
        ),
      );
    } else {
      // If the item already exists, show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.name} is already in preorders!'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: MyAppBar(title: 'S H O P P I N G   L I S T'),
      body: _items.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.pink,
            ))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                Item item = _items[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(item.imageUrl),
                    title: Text(item.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.description),
                        Text('\$${item.price.toString()}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.orangeAccent,
                        shadowColor: Colors.grey,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text('Preorder'),
                      onPressed: () => _addToPreorder(item),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
