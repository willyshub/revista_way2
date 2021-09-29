import 'dart:convert';
import 'dart:io';

class DocModel {
  DocModel({
    required this.size,
    required this.typeFile,
    required this.path,
    required this.name,
    //required this.file,
  });

  factory DocModel.fromMap(Map<String, dynamic> map) {
    return DocModel(
      size: map['size'] as int,
      typeFile: map['typeFile'] as String,
      path: map['path'] as String,
      name: map['name'] as String,
      //file: map['file'] as File,
    );
  }

  factory DocModel.fromJson(String source) =>
      DocModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String name;
  int size;
  String? path;
  File? file;
  String typeFile;

  DocModel copyWith({
    int? size,
    String? typeFile,
    String? path,
    String? name,
    // File? file,
  }) {
    return DocModel(
      size: size ?? this.size,
      typeFile: typeFile ?? this.typeFile,
      path: path ?? this.path,
      name: name ?? this.name,
      //file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'typeFile': typeFile,
      'path': path,
      'name': name,
      'file': file,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return "DocModel(size: $size, typeFile: $typeFile, path: $path, name: $name, file: $file)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DocModel &&
        other.size == size &&
        other.typeFile == typeFile &&
        other.path == path &&
        other.name == name &&
        other.file == file;
  }

  @override
  int get hashCode {
    return size.hashCode ^
        typeFile.hashCode ^
        path.hashCode ^
        name.hashCode ^
        file.hashCode;
  }
}
