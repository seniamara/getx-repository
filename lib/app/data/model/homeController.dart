import 'package:get/get.dart';
import 'package:getx/app/data/model/github_users.dart';
import 'package:getx/app/data/repository/github_respositry.dart';

class HomeController extends GetxController {
  final GithubRepository repository;
  final RxList<GithubUsers> users = <GithubUsers>[].obs;
  final RxBool isLoading = false.obs;

  HomeController({required this.repository});

  Future<void> getGithubUsers() async {
    isLoading.value = true;
    try {
      final fetchedUsers = await repository.getGithubUsers();
      users.assignAll(fetchedUsers);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
