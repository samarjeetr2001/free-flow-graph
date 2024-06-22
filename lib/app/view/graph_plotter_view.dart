import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_force_directed_graph/flutter_force_directed_graph.dart'
    as ffdg;
import 'package:get/get.dart';
import 'package:graphview_plotter/app/controller/graph_plotter_controller.dart';
import 'package:graphview_plotter/app/model/graph_model.dart';
import 'package:graphview_plotter/app/model/node_model.dart';
import 'package:graphview_plotter/app/view/widget/node_widget.dart';
import 'package:graphview_plotter/core/enum.dart';

import 'widget/error_widget.dart';
import 'package:graphview/GraphView.dart' as gv;
import 'package:zoom_widget/zoom_widget.dart';

class GraphPlotterView extends GetView<GraphPlotterController> {
  const GraphPlotterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Free Flow Graph'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Obx(() {
          final status = controller.graphDataRetrievalStatus.value;
          switch (status) {
            case DataRetrievalStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case DataRetrievalStatus.error:
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ErrorContainer(
                  error: controller.graphData?.exception?.message,
                ),
              );
            case DataRetrievalStatus.loaded:
              return _ForceDirectedGraphWidget(
                graphData: controller.graphData!.response!,
              );
            // return _GraphView(
            //   graphData: controller.graphData!.response!,
            // );
          }
        }),
      ),
    );
  }
}

class _ForceDirectedGraphWidget extends StatelessWidget {
  final GraphModel graphData;
  const _ForceDirectedGraphWidget({required this.graphData});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GraphPlotterController>();
    return GestureDetector(
      onScaleStart: (ScaleStartDetails details) {
        controller.previousScale = controller.ffdgController.scale;
      },
      onScaleUpdate: (ScaleUpdateDetails details) {
        controller.ffdgController.scale =
            controller.previousScale * details.scale;
      },
      onScaleEnd: (ScaleEndDetails details) {
        controller.previousScale = 1.0;
      },
      child: ffdg.ForceDirectedGraphWidget<GraphNodeModel>(
        controller: controller.ffdgController,
        nodesBuilder: (BuildContext context, nodeDetails) {
          return NodeWidget(
            nodeDetails: nodeDetails,
            size: 20 + 20 * (controller.maxDistance - nodeDetails.distance),
          );
        },
        edgesBuilder: (
          BuildContext context,
          GraphNodeModel? a,
          GraphNodeModel? b,
          double distance,
        ) {
          return Container(
            width: distance,
            height: 2,
            color: a?.userDetails == controller.selectedUser.value
                ? Colors.green[200]
                : b?.userDetails == controller.selectedUser.value
                    ? Colors.red[200]
                    : Colors.grey,
          );
        },
      ),
    );
  }
}

class _GraphView extends StatelessWidget {
  final GraphModel graphData;
  const _GraphView({required this.graphData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<GraphPlotterController>();
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(100),
      child: Zoom(
        backgroundColor: theme.scaffoldBackgroundColor,
        canvasColor: theme.scaffoldBackgroundColor,
        initTotalZoomOut: true,
        child: gv.GraphView(
          graph: graph,
          algorithm: gv.SugiyamaAlgorithm(configuration),
          paint: Paint()
            ..color = Colors.grey
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke,
          builder: (node) {
            final id = node.key!.value;
            final nodeDetails = graphData.nodes.firstWhere((n) => n.id == id);
            return NodeWidget(
              nodeDetails: nodeDetails,
              size: 50 + 20 * (controller.maxDistance - nodeDetails.distance),
            );
          },
        ),
      ),
    );
  }

  gv.Graph get graph {
    final _ = gv.Graph();

    for (final element in graphData.nodes) {
      _.addNode(gv.Node.Id(element.id));
    }

    for (final element in graphData.links) {
      _.addEdge(gv.Node.Id(element.source), gv.Node.Id(element.target));
    }
    return _;
  }

  gv.SugiyamaConfiguration get configuration {
    return gv.SugiyamaConfiguration()
      ..levelSeparation = 200
      ..nodeSeparation = 50
      ..orientation = 3
      ..bendPointShape = gv.MaxCurvedBendPointShape();
  }
}
