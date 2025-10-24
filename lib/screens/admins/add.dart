import 'package:flutter/material.dart';
import 'package:dart_tools/result.dart';
import 'package:go_router/go_router.dart';
import 'package:modulo_a_devlog/core/constants/sizes.dart';
import 'package:modulo_a_devlog/features/admin.dart';
import 'package:modulo_a_devlog/widgets/button.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';
import 'package:modulo_a_devlog/widgets/text_field.dart';
import 'package:flutter_tools/form_validator.dart';

class AdminAdd extends StatefulWidget {
  const AdminAdd({super.key});

  @override
  State<AdminAdd> createState() => _AdminAddState();
}

class _AdminAddState extends State<AdminAdd> {
  final nameController = InputEdittingController<String>("");
  final emailController = InputEdittingController<String>("");
  final passwordController = InputEdittingController<String>("");
  final passwordSecret = InputSecretController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar admin",
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: 800
              ),
              child: Card(
                child: Padding(
                  padding: AppPaddings.big,
                  child: Column(
                    spacing: 24,
                    children: [
                      Text("Adicionar admin"),
                      AppTextInput(
                        controller: nameController,
                        label: "Nome",
                      ),
                      AppTextInput(
                        controller: emailController,
                        label: "Email",
                      ),
                      AppTextInput(
                        controller: passwordController,
                        label: "Senha",
                        secret: passwordSecret,
                      ),
                      AppButton(
                        onPressed: () {
                          Admin.service.register(
                            name: nameController.value.trim(),
                            email: emailController.value.trim(),
                            password: passwordController.value.trim()
                          ).then((v) => v is Success ? context.go("/admins") : null);
                        },
                        child: const Text("Cadastrar")
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}