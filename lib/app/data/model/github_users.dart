
import 'dart:convert';

class GithubUsers {
  final String login;
  final String avatarUrl;
  final String? location;
  final int? followers;
  final int? publicRepositories;

  GithubUsers({
    required this.login,
    required this.avatarUrl,
    this.location,
    this.followers,
    this.publicRepositories,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'login': login});
    result.addAll({'avatarUrl': avatarUrl});
    if (location != null) result.addAll({'location': location});
    if (followers != null) result.addAll({'followers': followers});
    if (publicRepositories != null) {
      result.addAll({'publicRepositories': publicRepositories});
    }
    return result;
  }

  factory GithubUsers.fromMap(Map<String, dynamic> map) {
    return GithubUsers(
      login: map['login'] ?? '',
      avatarUrl: map['avatar_url'] ?? '',
      location: map['location'],
      followers: map['followers']?.toInt(),
      publicRepositories: map['public_repos']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GithubUsers.fromJson(String source) =>
      GithubUsers.fromMap(json.decode(source));
}
