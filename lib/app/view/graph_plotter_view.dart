import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphview_plotter/app/controller/graph_plotter_controller.dart';
import 'package:graphview_plotter/app/model/graph_model.dart';
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
              return _View(
                graphData: controller.graphData!.response!,
              );
          }
        }),
      ),
    );
  }
}

class _View extends StatelessWidget {
  final GraphModel graphData;
  const _View({required this.graphData});

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
            final user = nodeDetails.userDetails;
            final size =
                50 + 20 * (controller.maxDistance - nodeDetails.distance);
            return GestureDetector(
              onTap: () {
                controller.selectedUser.value = user;
              },
              child: Obx(
                () {
                  final selectedUser = controller.selectedUser.value;
                  return Container(
                    padding:
                        selectedUser == user ? const EdgeInsets.all(10) : null,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red[900],
                    ),
                    child: Container(
                      width: size,
                      height: size,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                        image: user.profileImg != null
                            ? DecorationImage(
                                image: NetworkImage(user.profileImg!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: user.profileImg != null
                          ? null
                          : Center(
                              child: Text(
                                user.name
                                    .substring(0, min(user.name.length, 4))
                                    .toUpperCase(),
                              ),
                            ),
                    ),
                  );
                },
              ),
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
