import 'package:flutter/material.dart';

class MaterialesScreen extends StatelessWidget {
  const MaterialesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Materiales',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Materiales'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.network(
                          'data:image/jpeg;base64,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',
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(width: 16),
                        Text('Cuero Legitimo'),
                        SizedBox(width: 16),
                        Text('20 m'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Proveedores'),
                        SizedBox(width: 16),
                        Text('15/10/2022'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.network(
                          'data:image/jpeg;base64,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',
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(width: 16),
                        Text('Cuero Sintetico'),
                        SizedBox(width: 16),
                        Text('50 m'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Proveedores'),
                        SizedBox(width: 16),
                        Text('15/10/2022'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.network(
                          'https://ebrand.pe/cdn/shop/articles/sdfsdf.png?v=1658530302&width=2048',
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(width: 16),
                        Text('Cuero Ecologico'),
                        SizedBox(width: 16),
                        Text('250 m'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Proveedores'),
                        SizedBox(width: 16),
                        Text('15/10/2022'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialesScreen());
}
