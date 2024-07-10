import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Transaction {
  final String id;
  final String description;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      description: json['description'],
      amount: json['amount'].toDouble(),
      date: DateTime.parse(json['date']),
    );
  }
}

class TransactionService {
  final String backendUrl = 'https://tu-backend-url.com/api/transactions'; // Reemplaza con tu URL

  Future<List<Transaction>> fetchTransactions() async {
    final response = await http.get(Uri.parse(backendUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((transaction) => Transaction.fromJson(transaction)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }
}

class ResumenCompraScreen extends StatelessWidget {
  const ResumenCompraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transaction App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TransactionService _transactionService = TransactionService();
  late Future<List<Transaction>> _transactions;

  @override
  void initState() {
    super.initState();
    _transactions = _transactionService.fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumen de Compras y Servicios'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _transactions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay transacciones disponibles'));
          }

          final transactions = snapshot.data!;
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return ListTile(
                title: Text(transaction.description),
                subtitle: Text(transaction.date.toString()),
                trailing: Text('\$${transaction.amount.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
    );
  }
}
