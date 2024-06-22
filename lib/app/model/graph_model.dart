import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:graphview_plotter/app/model/link_model.dart';
import 'package:graphview_plotter/app/model/node_model.dart';

class GraphModel {
  final List<GraphNodeModel> nodes;
  final List<GraphLinkModel> links;
  final GraphDetailsModel details;
  GraphModel({
    required this.nodes,
    required this.links,
    required this.details,
  });

  factory GraphModel.fromMap(Map<String, dynamic> map) {
    map = map['data']?['graph'] ?? {};

    return GraphModel(
      nodes: List<GraphNodeModel>.from(
        map['nodes']?.map((x) => GraphNodeModel.fromMap(x)),
      ),
      links: List<GraphLinkModel>.from(
        map['links']?.map((x) => GraphLinkModel.fromMap(x)),
      ),
      details: GraphDetailsModel.fromMap(map['graph_details'] ?? {}),
    );
  }

  @override
  String toString() =>
      'GraphModel(nodes: $nodes, links: $links, details: $details)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GraphModel &&
        listEquals(other.nodes, nodes) &&
        listEquals(other.links, links) &&
        other.details == details;
  }

  @override
  int get hashCode => nodes.hashCode ^ links.hashCode ^ details.hashCode;
}

class GraphDetailsModel {
  final int totalNodes;
  final int totalLinks;
  GraphDetailsModel({
    required this.totalNodes,
    required this.totalLinks,
  });

  factory GraphDetailsModel.fromMap(Map<String, dynamic> map) {
    return GraphDetailsModel(
      totalNodes: map['count_nodes']?.toInt() ?? 0,
      totalLinks: map['count_links']?.toInt() ?? 0,
    );
  }

  factory GraphDetailsModel.fromJson(String source) =>
      GraphDetailsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'GraphDetailsModel(totalNodes: $totalNodes, totalLinks: $totalLinks)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GraphDetailsModel &&
        other.totalNodes == totalNodes &&
        other.totalLinks == totalLinks;
  }

  @override
  int get hashCode => totalNodes.hashCode ^ totalLinks.hashCode;
}
