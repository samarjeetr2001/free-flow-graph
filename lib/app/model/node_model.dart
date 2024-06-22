import 'package:graphview_plotter/app/model/user_model.dart';

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
