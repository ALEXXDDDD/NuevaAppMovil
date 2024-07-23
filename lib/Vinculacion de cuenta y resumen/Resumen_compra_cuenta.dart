import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final String type; // Añadido el tipo de transacción

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.type, // Añadido el tipo de transacción
  });
}

class TransactionService {
  Future<List<Transaction>> fetchTransactions() async {
    await Future.delayed(Duration(seconds: 2)); // Simular una espera
    return [
      Transaction(
          id: '1',
          description: 'Compra 1',
          amount: 20.0,
          date: DateTime.now(),
          type: 'compra'), // Añadido el tipo de transacción
      Transaction(
          id: '2',
          description: 'Servicio 1',
          amount: 50.0,
          date: DateTime.now(),
          type: 'servicio'), // Añadido el tipo de transacción
    ];
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

  void _navigateToTransactionDetail(Transaction transaction) {
    if (transaction.type == 'compra') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompraDetailScreen(transaction: transaction),
        ),
      );
    } else if (transaction.type == 'servicio') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServicioDetailScreen(transaction: transaction),
        ),
      );
    }
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
                onTap: () => _navigateToTransactionDetail(transaction),
              );
            },
          );
        },
      ),
    );
  }
}

class CompraDetailScreen extends StatelessWidget {
  final Transaction transaction;

  const CompraDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Compra'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${transaction.id}'),
            Text('Descripción: ${transaction.description}'),
            Text('Monto: \$${transaction.amount}'),
            Text('Fecha: ${transaction.date}'),
          ],
        ),
      ),
    );
  }
}

class ServicioDetailScreen extends StatelessWidget {
  final Transaction transaction;

  const ServicioDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Servicio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${transaction.id}'),
            Text('Descripción: ${transaction.description}'),
            Text('Monto: \$${transaction.amount}'),
            Text('Fecha: ${transaction.date}'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(ResumenCompraScreen());
}
