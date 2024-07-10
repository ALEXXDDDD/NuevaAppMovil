import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReporteDatosScreen extends StatelessWidget {
  const ReporteDatosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reporte Datos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> compras = [];

  @override
  void initState() {
    super.initState();
    // Aquí llamas a tu backend para obtener las compras y servicios
    fetchComprasYServicios();
  }

  void fetchComprasYServicios() async {
    final url =
        'https://tu-backend.com/api/compras'; // Reemplaza esta URL con la URL real de tu backend
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> fetchedCompras = json.decode(response.body);
        setState(() {
          compras = fetchedCompras
              .map((compra) => {
                    'id': compra['id'],
                    'producto': compra['producto'],
                    'precio': compra['precio'],
                    'fecha': compra['fecha'],
                  })
              .toList();
        });
      } else {
        throw Exception('Failed to load compras');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Manejo de errores: Puedes mostrar un mensaje al usuario o realizar otras acciones
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumen de Compra'),
      ),
      body: ListView(
        children: [
          Section(title: 'Compras', items: compras, itemType: 'compra'),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final String itemType;

  Section({required this.title, required this.items, required this.itemType});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      children: items
          .map((item) => ListTile(
                title: Text(
                    itemType == 'compra' ? item['producto'] : item['servicio']),
                subtitle: Text('Fecha: ${item['fecha']}'),
                trailing: Text('Precio: \$${item['precio']}'),
              ))
          .toList(),
    );
  }
}
