import 'package:first_stock_example/jsondata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FirStock Example Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyCustomTable(),
    );
  }
}

class MyCustomTable extends StatefulWidget {
  const MyCustomTable({super.key});

  @override
  State<MyCustomTable> createState() => _MyCustomTableState();
}

class _MyCustomTableState extends State<MyCustomTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example 1"),
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final cakesAsync = ref.watch(cakesPod);
            return cakesAsync.when(
              data: (cakes) {
                return InteractiveViewer(
                  constrained: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: TableBorder.all(width: 1),
                      columnWidths: const {
                        0: FixedColumnWidth(45),
                        1: FixedColumnWidth(50),
                        2: FixedColumnWidth(50),
                        3: FixedColumnWidth(50),
                        4: FixedColumnWidth(60),
                        5: FixedColumnWidth(170),
                      },
                      defaultColumnWidth: const FlexColumnWidth(),
                      children: [
                        const TableRow(children: [
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'id',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'type',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'name',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'ppu',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'batter',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'topping',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ]),
                        ...cakes
                            .map((cake) => TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(cake['id']),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(cake['type']),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(cake['name']),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(cake['ppu'].toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(cake['type']),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(cake['topping']),
                                  ),
                                ]))
                            .toList(),
                      ],
                    ),
                  ),
                );
              },
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
              loading: () => const CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
