import 'package:meta/meta.dart';

class Organization {
  final int id;

  final String name;

  final String avatarUrl;

  final String description;

  Organization(
      {@required this.id,
      @required this.name,
      @required this.avatarUrl,
      @required this.description});
}
