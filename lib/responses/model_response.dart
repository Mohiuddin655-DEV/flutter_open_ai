class ModelResponse {
  final String? object;
  final List<Model>? data;

  const ModelResponse({
    this.object,
    this.data,
  });

  ModelResponse copy({
    String? object,
    List<Model>? data,
  }) {
    return ModelResponse(
      object: object ?? this.object,
      data: data ?? this.data,
    );
  }

  factory ModelResponse.from(Map<String, dynamic> source) {
    final object = source["object"];
    final data = source["data"];
    return ModelResponse(
      object: object is String ? object : null,
      data: data is List ? data.map((e) => Model.from(e)).toList() : [],
    );
  }

  Map<String, dynamic> get source {
    return {
      "object": object,
      "data": data?.map((e) => e.source),
    };
  }
}

class Model {
  final String? id;
  final String? object;
  final int? created;
  final String? ownedBy;

  const Model({
    this.id,
    this.object,
    this.created,
    this.ownedBy,
  });

  Model copy({
    String? id,
    String? object,
    int? created,
    String? ownedBy,
  }) {
    return Model(
      id: id ?? this.id,
      object: object ?? this.object,
      created: created ?? this.created,
      ownedBy: ownedBy ?? this.ownedBy,
    );
  }

  factory Model.from(Map<String, dynamic> source) {
    final id = source["id"];
    final object = source["object"];
    final created = source["created"];
    final ownedBy = source["owned_by"];
    return Model(
      id: id is String ? id : null,
      object: object is String ? object : null,
      created: created is int ? created : null,
      ownedBy: ownedBy is String ? ownedBy : null,
    );
  }

  Map<String, dynamic> get source {
    return {
      "id": id,
      "object": object,
      "created": created,
      "owned_by": ownedBy,
    };
  }
}
