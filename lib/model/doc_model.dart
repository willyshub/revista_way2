import 'dart:convert';

class DocModel {
  DocModel({
    required this.size,
    required this.extension,
    required this.path,
    required this.name,
  });

  factory DocModel.fromMap(Map<String, dynamic> map) {
    return DocModel(
      size: map['size'] as int,
      extension: map['extension'] as String,
      path: map['path'] as String,
      name: map['name'] as String,
    );
  }


  int size;
  String extension;
  String path;
  String name;

  DocModel copyWith({
    int? size,
    String? extension,
    String? path,
    String? name,
  }) {
    return DocModel(
      size: size ?? this.size,
      extension: extension ?? this.extension,
      path: path ?? this.path,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'extension': extension,
      'path': path,
      'name': name,
    };
  }

  String toJson() => json.encode(toMap());

  factory DocModel.fromJson(String source) =>
      DocModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return "DocModel(size: $size, extension: $extension, path: $path, name: $name)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DocModel &&
        other.size == size &&
        other.extension == extension &&
        other.path == path &&
        other.name == name;
  }

  @override
  int get hashCode {
    return size.hashCode ^ extension.hashCode ^ path.hashCode ^ name.hashCode;
  }
}
