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
