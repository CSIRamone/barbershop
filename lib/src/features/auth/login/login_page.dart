import 'package:barbershop/src/core/ui/constants.dart';
import 'package:barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:barbershop/src/core/ui/helpers/messages.dart';
import 'package:barbershop/src/features/auth/login/login_state.dart';
import 'package:barbershop/src/features/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);
    ref.listen(loginVmProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;
        case LoginState(status: LoginStateStatus.error, :final errorMessage?):
          Messages.showError(errorMessage, context);
        case LoginState(status: LoginStateStatus.error):
          Messages.showError('Erro ao realizar login', context);
        case LoginState(status: LoginStateStatus.admLogin):
          Navigator.of(context).pushNamedAndRemoveUntil('home/adm', (route)  => false); 
        break;
        case LoginState(status: LoginStateStatus.employeeLogin):
          Navigator.of(context).pushNamedAndRemoveUntil('home/employee', (route)  => false);
        break;
      }
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImageConstants.backgroundChair,
              ),
              opacity: 0.6,
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImageConstants.imageLogo),
                          const SizedBox(height: 24),
                          TextFormField(
                            onTapOutside: (_) => context.unfocus(),
                            validator: Validatorless.multiple([
                              Validatorless.required('E-mail obrigatório'),
                              Validatorless.email('E-mail inválido'),
                            ]),
                            controller: emailEC,
                            decoration: const InputDecoration(
                                label: Text('E-mail'),
                                hintText: 'E-mail',
                                hintStyle: TextStyle(color: Colors.black),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            onTapOutside: (_) => context.unfocus(),
                            obscureText: true,
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatória'),
                              Validatorless.min(
                                  6, 'Senha deve ter no mínimo 6 caracteres'),
                            ]),
                            decoration: const InputDecoration(
                                label: Text('Senha'),
                                hintText: 'Senha',
                                hintStyle: TextStyle(color: Colors.black),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                )),
                            controller: passwordEC,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(
                                    color: ColorsConstants.brow,
                                    fontSize: 12,
                                  ),
                                )),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                            ),
                            onPressed: () {
                              switch (_formKey.currentState?.validate()) {
                                case (false || null):
                                  //mostrar uma mensagem de erro campos invalidos
                                  Messages.showError(
                                      'Campos inválidos', context);
                                  break;
                                case (true):
                                  login(
                                    emailEC.text,
                                    passwordEC.text,
                                  );
                              }
                            },
                            child: const Text(
                              'Acessar',
                            ),
                          ),
                        ],
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('Criar conta',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
