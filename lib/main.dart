import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final amount = TextEditingController();

  late final category = TextEditingController();

  late final List<Map<String, dynamic>> expenses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade200),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Expense Tracker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 8),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              '${expenses.fold(0, (sum, item) => sum + int.parse(item['amount']))} EGP',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Icon(
                  switch (expenses[index]['category']) {
                    'Food' => Icons.fastfood,
                    'Transportation' => Icons.directions_walk,
                    'Shopping' => Icons.shopping_cart,
                    _ => Icons.error,
                  },
                  color: switch (expenses[index]['category']) {
                    'Food' => Colors.orange,
                    'Transportation' => Colors.blue,
                    'Shopping' => Colors.green,
                    _ => Colors.grey,
                  },
                ),
              ),
              title: Text(
                '${expenses[index]['amount']} EGP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              subtitle: Text(
                expenses[index]['category'],
                style: TextStyle(color: Color(0xFF1E293B)),
              ),
              trailing: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      expenses.removeAt(index);
                    });
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              tileColor: Colors.white,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog.adaptive(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                icon: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green[100],
                  child: Icon(Icons.add, size: 40, color: Colors.green),
                ),
                title: Text(
                  'Add New Expense',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        controller: amount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Expense Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Expense Category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: [
                          DropdownMenuItem(value: 'Food', child: Text('Food')),
                          DropdownMenuItem(
                            value: 'Transportation',
                            child: Text('Transportation'),
                          ),
                          DropdownMenuItem(
                            value: 'Shopping',
                            child: Text('Shopping'),
                          ),
                        ],
                        onChanged: (value) {
                          category.text = value.toString();
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (amount.text.isNotEmpty && category.text.isNotEmpty) {
                        expenses.add({
                          'amount': amount.text,
                          'category': category.text,
                        });
                      }
                      Navigator.of(context).pop();
                      amount.clear();
                      category.clear();
                      setState(() {
                        expenses;
                      });
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.green),
      ),
    );
  }
}
