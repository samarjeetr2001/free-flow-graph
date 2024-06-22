import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphview_plotter/app/binding/graph_plotter_binding.dart';
import 'package:graphview_plotter/app/view/graph_plotter_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final graphRoute = "/graph-plotter";

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: graphRoute,
      getPages: [
        GetPage(
          name: graphRoute,
          page: () => const GraphPlotterView(),
          binding: GraphPlotterBinding(),
        ),
      ],
    );
  }
}
