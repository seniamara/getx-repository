import 'package:dio/dio.dart';
import 'package:getx/app/data/model/github_users.dart';

class GithubRepository {
  final Dio dio;

  GithubRepository({required this.dio});

  Future<List<GithubUsers>> getGithubUsers() async {
    final response = await dio.get("https://api.github.com/users");
    final List<GithubUsers> users = [];
    if (response.statusCode == 200) {
      response.data.forEach((item) {
        users.add(GithubUsers.fromMap(item));
      });
    } else {
      throw Exception('Failed to load users');
    }
    return users;
  }
}