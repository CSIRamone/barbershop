import 'package:barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
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
                          decoration: const InputDecoration(
                              label: Text('Senha'),
                              hintText: 'Senha',
                              hintStyle: TextStyle(color: Colors.black),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(
                                color: Colors.black,
                              )),
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
                          onPressed: () {},
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
    );
  }
}
