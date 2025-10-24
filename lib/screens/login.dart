import 'package:flutter/material.dart';
import 'package:flutter_tools/form_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modulo_a_devlog/core/constants.dart';
import 'package:modulo_a_devlog/widgets/button.dart';
import 'package:modulo_a_devlog/widgets/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = InputEdittingController<String>("");
  final passwordController = InputEdittingController<String>("");
  final secret = InputSecretController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final axis = mediaQuery.size.width > 700 ? Axis.horizontal : Axis.vertical;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kFloatingActionButtonMargin,
            vertical: 36
          ),
          child: Center(
            child: Padding(
              padding: axis == Axis.horizontal ? const EdgeInsets.symmetric(
                horizontal: 64,
                vertical: 96
              ) : EdgeInsets.zero,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 1000
                ),
                decoration: BoxDecoration(
                  borderRadius: AppBorderRadius.giant,
                  color: AppColors.base.shade100
                ),
                clipBehavior: Clip.antiAlias,
                child: Flex(
                  direction: axis,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: axis == Axis.horizontal ? 16 : 32,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: axis == Axis.horizontal ? 1 : 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: axis == Axis.horizontal ? EdgeInsets.zero : const EdgeInsets.all(24.0),
                            child: Image.asset("assets/images/logo_1.png"),
                          )
                        ],
                      )
                    ),
                    Expanded(
                      flex: axis == Axis.horizontal ? 1 : 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: axis == Axis.horizontal ? AppColors.blue : null
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Entrar", style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: axis == Axis.horizontal ? Colors.white : AppColors.base
                            ),),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppTextInput(
                                    label: "E-mail",
                                    leading: FontAwesomeIcons.envelope,
                                    controller: emailController,
                                    border: const BorderSide(color: Colors.white, width: 2),
                                    textStyle: TextStyle(
                                      color: axis == Axis.horizontal ? Colors.white : AppColors.base
                                    ),
                                  ),
                                  AppTextInput(
                                    label: "Senha",
                                    leading: FontAwesomeIcons.lock,
                                    controller: passwordController,
                                    secret: secret,
                                    border: const BorderSide(color: Colors.white, width: 2),
                                    textStyle: TextStyle(
                                      color: axis == Axis.horizontal ? Colors.white : AppColors.base
                                    )
                                  ),
                                  AppButton(
                                    onPressed: () {
                                      
                                    },
                                    color: axis == Axis.horizontal ? Colors.white : AppColors.blue,
                                    child: const Text("Entrar"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}