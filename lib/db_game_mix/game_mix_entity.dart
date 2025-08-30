class GridGameEntity {
  final int order;
  final String type;
  String value;

  GridGameEntity({
    required this.order,
    required this.type,
    required this.value,
  });

  GridGameEntity copyWith({int? order, String? type, String? value}) {
    return GridGameEntity(
      order: order ?? this.order,
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {'sort_order': order, 'type': type, 'value': value};
  }

  factory GridGameEntity.fromMap(Map<String, dynamic> map) {
    return GridGameEntity(
      order: map['sort_order'],
      type: map['type'],
      value: map['value'],
    );
  }

  @override
  String toString() {
    return 'GridGame(type: $type, order: $order, value: $value)';
  }
}

List<GridGameEntity> gridGameInitList = [
  GridGameEntity(order: 0, type: 'Project Title', value: 'grid game'),
  GridGameEntity(order: 1, type: 'Project 1', value: 'Go 1'),
  GridGameEntity(order: 2, type: 'Project 2', value: 'Go 2'),
  GridGameEntity(order: 3, type: 'Project 3', value: 'Go 3'),
  GridGameEntity(order: 4, type: 'Project 4', value: 'Go 4'),
  GridGameEntity(order: 5, type: 'Project 5', value: 'Go 5'),
  GridGameEntity(order: 6, type: 'Project 6', value: 'Go 6'),
  GridGameEntity(order: 7, type: 'Project 7', value: 'Go 7'),
  GridGameEntity(order: 8, type: 'Project 8', value: 'Go 8'),
  GridGameEntity(order: 9, type: 'Project 9', value: 'Go 9'),
];

class DrawLotsEntity {
  final String result;
  final double probability;
  final DateTime? createdAt;

  DrawLotsEntity({
    required this.result,
    required this.probability,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'result': result,
      'probability': probability,
      'created_at': createdAt ?? DateTime.now().toIso8601String(),
    };
  }

  factory DrawLotsEntity.fromMap(Map<String, dynamic> map) {
    return DrawLotsEntity(
      result: map['result'] ?? '',
      probability: map['probability']?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  @override
  String toString() {
    return 'DrawLotsEntity(result: $result, probability: $probability, createdAt: $createdAt)';
  }
}
