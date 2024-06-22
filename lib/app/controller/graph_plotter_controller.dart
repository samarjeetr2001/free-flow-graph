import 'package:get/get.dart';
import 'package:graphview_plotter/app/model/graph_model.dart';
import 'package:graphview_plotter/app/repository/graph_plotter_repository.dart';
import 'package:graphview_plotter/core/enum.dart';
import 'package:graphview_plotter/network/rest_response.dart';

class GraphPlotterController extends GetxController {
  final _repository = GraphPlotterRepository();

  final graphDataRetrievalStatus = DataRetrievalStatus.loading.obs;
  RestResponse<GraphModel>? graphData;
  double maxDistance = 5;

  @override
  void onReady() {
    super.onReady();
    fetchGraphData();
  }

  Future<void> fetchGraphData() async {
    graphData = await _repository.fetchGraphDetails();
    if (!graphData!.hasError && graphData!.response is GraphModel) {
      maxDistance = graphData!.response!.nodes.last.distance.toDouble();
      graphDataRetrievalStatus.value = DataRetrievalStatus.loaded;
    } else {
      graphDataRetrievalStatus.value = DataRetrievalStatus.error;
    }
  }
}
