import 'dart:convert';

class DocModel {
  int size;
  String extension;
  String path;
  String name;
  DocModel({
    required this.size,
    required this.extension,
    required this.path,
    required this.name,
  });

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

  factory DocModel.fromMap(Map<String, dynamic> map) {
    return DocModel(
      size: map['size'],
      extension: map['extension'],
      path: map['path'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DocModel.fromJson(String source) =>
      DocModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DocModel(size: $size, extension: $extension, path: $path, name: $name)';
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
