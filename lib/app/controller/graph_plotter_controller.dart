import 'package:flutter_force_directed_graph/flutter_force_directed_graph.dart'
    as ffdg;
import 'package:get/get.dart';
import 'package:graphview_plotter/app/model/graph_model.dart';
import 'package:graphview_plotter/app/model/node_model.dart';
import 'package:graphview_plotter/app/model/user_model.dart';
import 'package:graphview_plotter/app/repository/graph_plotter_repository.dart';
import 'package:graphview_plotter/core/enum.dart';
import 'package:graphview_plotter/network/rest_response.dart';

class GraphPlotterController extends GetxController {
  final _repository = GraphPlotterRepository();

  final graphDataRetrievalStatus = DataRetrievalStatus.loading.obs;
  RestResponse<GraphModel>? graphData;
  double maxDistance = 5;

  double previousScale = 1.0;

  final Rxn<UserModel> selectedUser = Rxn();
  final ffdgController = ffdg.ForceDirectedGraphController<GraphNodeModel>();

  @override
  void onReady() {
    super.onReady();
    fetchGraphData();
  }

  Future<void> fetchGraphData() async {
    graphData = await _repository.fetchGraphDetails();
    if (!graphData!.hasError && graphData!.response is GraphModel) {
      maxDistance = graphData!.response!.nodes.last.distance.toDouble();
      _setController();
      graphDataRetrievalStatus.value = DataRetrievalStatus.loaded;
    } else {
      graphDataRetrievalStatus.value = DataRetrievalStatus.error;
    }
  }

  void _setController() {
    final data = graphData!.response!;
    for (final element in data.nodes) {
      ffdgController.addNode(element);
    }
    for (final element in data.links) {
      final source = data.nodes.firstWhere((e) => e.id == element.source);
      final target = data.nodes.firstWhere((e) => e.id == element.target);
      if (!ffdgController.graph.edges.contains(
        ffdg.Edge(ffdg.Node(source), ffdg.Node(target)),
      )) {
        ffdgController.addEdgeByData(
          data.nodes.firstWhere((e) => e.id == element.source),
          data.nodes.firstWhere((e) => e.id == element.target),
        );
      }
    }
    ffdgController.scale = 0.6;

    ffdgController.needUpdate();
    update();
  }

  @override
  void dispose() {
    ffdgController.dispose();
    super.dispose();
  }
}
