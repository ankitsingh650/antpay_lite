
import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';
@JsonSerializable()
class Post{
  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  @JsonKey(name: 'userId')
  dynamic userId;


  @JsonKey(name: 'id')
  dynamic id;

  @JsonKey(name: 'title')
  String? title;


  @JsonKey(name: 'body')
  String? body;

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

}