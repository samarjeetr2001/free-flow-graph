import 'package:get/get.dart';
import 'package:graphview_plotter/app/controller/graph_plotter_controller.dart';

class GraphPlotterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GraphPlotterController());
  }
}
