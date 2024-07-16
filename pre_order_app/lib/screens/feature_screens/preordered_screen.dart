import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pre_order_app/models/item_model.dart';
import 'package:pre_order_app/widgets/my_appbar.dart';

class PreorderedScreen extends StatefulWidget {
  @override
  _PreorderedScreenState createState() => _PreorderedScreenState();
}

class _PreorderedScreenState extends State<PreorderedScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = true;
  List<DocumentSnapshot> _preorderedItems = [];

  @override
  void initState() {
    super.initState();
    _fetchPreorderedItems();
  }

  Future<void> _fetchPreorderedItems() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('preorders').get();
      setState(() {
        _preorderedItems = snapshot.docs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching preordered items: $e');
    }
  }

    Future<void> _deletePreorderedItem(String docId) async {
    try {
      await _firestore.collection('preorders').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deleted from preorders!'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _preorderedItems.removeWhere((item) => item.id == docId);
      });
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'P R E O R D E R E D   L I S T'),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.pink,
              ),
            )
          : _preorderedItems.isEmpty
              ? Center(
                  child: Text(
                    'No preordered items',
                    style: TextStyle(
                      fontSize: 18,
                    ),),
                )
              : ListView.builder(
                  itemCount: _preorderedItems.length,
                  itemBuilder: (context, index) {
                    var item = _preorderedItems[index];
                    return ListTile(
                      leading: Image.network(item['imageUrl']),
                      title: Text(item['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['description']),
                          Text('\$${item['price'].toString()}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            _deletePreorderedItem(item.id);
                          },
                          icon: Icon(Icons.delete)),
                    );
                  },
                ),
    );
  }
}
