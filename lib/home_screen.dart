import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:login/my_account.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'card_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CardItem> allItems = []; // Menyimpan daftar asli
  List<CardItem> cardItems = []; // Menyimpan daftar yang ditampilkan

  @override
  void initState() {
    super.initState();
    _loadInitialProduct();
    _loadItemsFromPrefs();
  }

  Future<void> _loadInitialProduct() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsString = prefs.getString('cardItems');

    if (itemsString == null) {
      final imageData1 = await rootBundle.load('images/baju1.png');
      final imageData2 = await rootBundle.load('images/baju2.png');
      final imageData3 = await rootBundle.load('images/baju3.png');

      final initialItems = [
        CardItem(
          title: 'Baju 1',
          pricing: 'Rp 100.000',
          image: imageData1.buffer.asUint8List(),
        ),
        CardItem(
          title: 'Baju 2',
          pricing: 'Rp 120.000',
          image: imageData2.buffer.asUint8List(),
        ),
        CardItem(
          title: 'Baju 3',
          pricing: 'Rp 150.000',
          image: imageData3.buffer.asUint8List(),
        ),
      ];

      setState(() {
        allItems.addAll(initialItems);
        cardItems.addAll(initialItems);
      });

      _saveItemsToPrefs();
    }
  }

  Future<void> _loadItemsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsString = prefs.getString('cardItems');

    if (itemsString != null) {
      final List<dynamic> jsonItems = jsonDecode(itemsString);
      setState(() {
        allItems = jsonItems.map((e) => CardItem.fromJson(e)).toList();
        cardItems = List.from(allItems);
      });
    }
  }

  Future<void> _saveItemsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsString = jsonEncode(allItems.map((e) => e.toJson()).toList());
    await prefs.setString('cardItems', itemsString);
  }

  void addProduct(CardItem item) {
    setState(() {
      allItems.add(item);
      cardItems.add(item);
    });
    _saveItemsToPrefs();
  }

  void editProduct(int index, CardItem updatedItem) {
    setState(() {
      allItems[index] = updatedItem;
      cardItems[index] = updatedItem;
    });
    _saveItemsToPrefs();
  }

  void deleteProduct(int index) {
    setState(() {
      allItems.removeAt(index);
      cardItems.removeAt(index);
    });
    _saveItemsToPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Tindakan untuk ikon akun
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Account'),
                    content: const Text('Account features coming soon!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Close'),
                      ),

// Tambahkan tombol Account
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MyAccountScreen(),
                          ),
                        ),
                        child: const Text('Account'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Products',
                  hintStyle:
                      const TextStyle(fontSize: 14.0, color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
                onChanged: (query) {
                  setState(() {
                    cardItems = allItems
                        .where((item) => item.title
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();
                  });
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: cardItems.length,
                itemBuilder: (context, index) {
                  return buildCardItem(cardItems[index], index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newItem = await showProductForm(context);
          if (newItem != null) {
            addProduct(newItem);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildCardItem(CardItem cardItem, int index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: cardItem.image.isNotEmpty
                  ? Image.memory(
                      cardItem.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Text("No Image"),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardItem.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  cardItem.pricing,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () async {
                        final updatedItem = await showProductForm(context,
                            initialItem: cardItem);
                        if (updatedItem != null) {
                          editProduct(index, updatedItem);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteProduct(index),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<CardItem?> showProductForm(BuildContext context,
      {CardItem? initialItem}) async {
    final titleController = TextEditingController(
        text: initialItem != null ? initialItem.title : '');
    final pricingController = TextEditingController(
        text: initialItem != null ? initialItem.pricing : '');
    Uint8List? selectedImage = initialItem?.image;

    return showDialog<CardItem>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(initialItem == null ? 'Add Product' : 'Edit Product'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: pricingController,
                    decoration: const InputDecoration(labelText: 'Pricing'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);

                      if (pickedFile != null) {
                        final imageBytes = await pickedFile.readAsBytes();
                        setState(() {
                          selectedImage = imageBytes;
                        });
                      }
                    },
                    child: const Text("Select Image"),
                  ),
                  const SizedBox(height: 10),
                  if (selectedImage != null)
                    Image.memory(
                      selectedImage!,
                      height: 100,
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (titleController.text.isEmpty ||
                        pricingController.text.isEmpty ||
                        selectedImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill all fields!"),
                        ),
                      );
                      return;
                    }

                    final newItem = CardItem(
                      title: titleController.text,
                      pricing: pricingController.text,
                      image: selectedImage!,
                    );
                    Navigator.of(context).pop(newItem);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
