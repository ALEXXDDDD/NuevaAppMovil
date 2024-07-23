import 'package:flutter/material.dart';
import 'package:zapateria/Informacion/InformacionProducto.dart';

// Definición de una clase Producto
class Producto {
  String nombre;
  String imageUrl;

  Producto({required this.nombre, required this.imageUrl});
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Producto',
      home: ProductScreen(),
    );
  }

  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                // Obtener el producto actual
                Producto producto = productos[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InformacionProductoScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.network(
                          producto.imageUrl,
                          height: 120,
                          width: 120,
                          errorBuilder: (context, error, stackTrace) {
                            return Text('Error al cargar la imagen');
                          },
                        ),
                        SizedBox(height: 8),
                        Text(producto.nombre),
                        SizedBox(height: 8),
                        Text(
                          "⭐⭐⭐⭐",
                          style: TextStyle(fontSize: 9),
                        ),
                      ],
                    ),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(211, 172, 12, 212)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Lista de productos
  final List<Producto> productos = [
    Producto(
      nombre: 'Botines',
      imageUrl:
          'data:image/jpeg;base64,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',
    ),
    Producto(
      nombre: 'Zapatos',
      imageUrl:
          'data:image/jpeg;base64,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',
    ),
    Producto(
      nombre: 'Vallerinas',
      imageUrl:
          'data:image/jpeg;base64,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',
    ),
    // Puedes añadir más productos aquí
  ];
}
