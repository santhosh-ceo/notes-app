import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  Note({required this.id, required this.title, required this.content});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
        id: json['id'], title: json['title'], content: json['content']);
  }
  @override
  // TODO: implement props
  List<Object?> get props => [id, title, content];
}
