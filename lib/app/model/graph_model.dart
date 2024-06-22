import 'dart:convert';

import 'package:flutter/foundation.dart';

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

class GraphNodeModel {
  final String id;
  final int distance;
  final String catagory;
  final String? ancestor;
  final UserModel userDetails;
  GraphNodeModel({
    required this.id,
    required this.distance,
    required this.catagory,
    this.ancestor,
    required this.userDetails,
  });

  factory GraphNodeModel.fromMap(Map<String, dynamic> map) {
    return GraphNodeModel(
      id: map['id']?.toString() ?? '',
      distance: map['distance']?.toInt() ?? 0,
      catagory: map['catagory'] ?? '',
      ancestor: map['ancestor'],
      userDetails: UserModel.fromMap(map['data']?['details'] ?? {}),
    );
  }

  @override
  String toString() {
    return 'GraphNodeModel(id: $id, distance: $distance, catagory: $catagory, ancestor: $ancestor, userDetails: $userDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GraphNodeModel &&
        other.id == id &&
        other.distance == distance &&
        other.catagory == catagory &&
        other.ancestor == ancestor &&
        other.userDetails == userDetails;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        distance.hashCode ^
        catagory.hashCode ^
        ancestor.hashCode ^
        userDetails.hashCode;
  }
}

class UserModel {
  final String name;
  final String? profileImg;
  UserModel({
    required this.name,
    this.profileImg,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['display_name'] ?? '',
      profileImg: map['display_picture'],
    );
  }

  @override
  String toString() => 'UserModel(name: $name, profileImg: $profileImg)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.profileImg == profileImg;
  }

  @override
  int get hashCode => name.hashCode ^ profileImg.hashCode;
}

class GraphLinkModel {
  final String source;
  final String target;
  final String category;
  GraphLinkModel({
    required this.source,
    required this.target,
    required this.category,
  });

  factory GraphLinkModel.fromMap(Map<String, dynamic> map) {
    return GraphLinkModel(
      source: map['source']?.toString() ?? '',
      target: map['target']?.toString() ?? '',
      category: map['category'] ?? '',
    );
  }

  @override
  String toString() =>
      'GraphLinkModel(source: $source, target: $target, category: $category)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GraphLinkModel &&
        other.source == source &&
        other.target == target &&
        other.category == category;
  }

  @override
  int get hashCode => source.hashCode ^ target.hashCode ^ category.hashCode;
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
