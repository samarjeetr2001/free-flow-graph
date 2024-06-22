import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphview_plotter/app/model/node_model.dart';

import '../../controller/graph_plotter_controller.dart';

class NodeWidget extends StatelessWidget {
  final GraphNodeModel nodeDetails;
  final double size;

  const NodeWidget({super.key, required this.nodeDetails, required this.size});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GraphPlotterController>();

    final user = nodeDetails.userDetails;
    return GestureDetector(
      onTap: () {
        controller.selectedUser.value = user;
      },
      child: Obx(
        () {
          final isSelectedUser = user == controller.selectedUser.value;

          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                width: isSelectedUser ? 2 : 1,
                color: isSelectedUser ? Colors.blue[900]! : Colors.grey,
              ),
              shape: BoxShape.circle,
              color: Theme.of(context).scaffoldBackgroundColor,
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
                  : FittedBox(
                      child: Text(
                        user.name
                            .substring(0, min(user.name.length, 4))
                            .toUpperCase(),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
