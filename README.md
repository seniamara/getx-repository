
```markdown
# GitHub Users App

Este projeto é um aplicativo Flutter que utiliza a API pública do GitHub para exibir uma lista de usuários, incluindo suas informações básicas, como login, avatar e localização. O aplicativo é estruturado usando o padrão **GetX** para gerenciamento de estado.

---

 ✨ Funcionalidades

- Exibir uma lista de usuários do GitHub.
- Mostrar informações como:
  - Nome de usuário (login).
  - Avatar do usuário.
  - Localização (quando disponível).
- Indicador de carregamento enquanto os dados são obtidos da API.
- Tratamento de erros ao falhar na obtenção dos dados.

---

 🚀 Tecnologias Utilizadas

- Flutter: Framework principal para desenvolvimento do aplicativo.
- Dio: Biblioteca para realizar requisições HTTP.
- GetX: Gerenciamento de estado e injeção de dependências.

---

« 🛠 Estrutura do Código

📁 Model

O modelo `GithubUsers` é responsável por mapear os dados recebidos da API.

```dart
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

  factory GithubUsers.fromMap(Map<String, dynamic> map) {
    return GithubUsers(
      login: map['login'] ?? '',
      avatarUrl: map['avatar_url'] ?? '',
      location: map['location'],
      followers: map['followers']?.toInt(),
      publicRepositories: map['public_repos']?.toInt(),
    );
  }
}
```

# 📁 Repository

O repositório `GithubRepository` lida com as requisições à API do GitHub e retorna os dados no formato esperado pelo modelo.

```dart
class GithubRepository {
  final Dio dio;

  GithubRepository({required this.dio});

  Future<List<GithubUsers>> getGithubUsers() async {
    final response = await dio.get("https://api.github.com/users");
    if (response.statusCode == 200) {
      return response.data.map<GithubUsers>((item) {
        return GithubUsers.fromMap(item);
      }).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
```

### 📁 Controller

O `HomeController` gerencia o estado do aplicativo e faz a comunicação entre o repositório e a interface do usuário.

```dart
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
```

### 📁 View

A interface do usuário é construída usando widgets do Flutter e observa o estado do `HomeController`.

```dart
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController(repository: GithubRepository(dio: Dio()));
    controller.getGithubUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GitHub Users"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              final user = controller.users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatarUrl),
                ),
                title: Text(user.login),
                subtitle: Text(user.location ?? "No location available"),
              );
            },
          );
        }
      }),
    );
  }
}
```

---

## 🖥 Como Rodar o Projeto

### Pré-requisitos
- Flutter SDK instalado ([guia de instalação](https://docs.flutter.dev/get-started)).
- Conexão com a internet.
- Emulador ou dispositivo físico conectado.

### Passos
1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/github-users-app.git
   ```
2. Entre na pasta do projeto:
   ```bash
   cd github-users-app
   ```
3. Instale as dependências:
   ```bash
   flutter pub get
   ```
4. Execute o projeto:
   ```bash
   flutter run
   ```

---

## 📚 Recursos Adicionais

- [Documentação Flutter](https://docs.flutter.dev/)
- [Dio - Biblioteca de Requisições HTTP](https://pub.dev/packages/dio)
- [GetX - Gerenciamento de Estado](https://pub.dev/packages/get)

---

## 🤝 Contribuições

Sinta-se à vontade para abrir issues ou enviar pull requests para melhorar o projeto!

---

## 📄 Licença

Este projeto está sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais informações.
```

### **Como usar?**
- Substitua `seu-usuario` na URL do repositório pelo nome de usuário do GitHub.
- Atualize a seção de licença, caso não seja MIT.

