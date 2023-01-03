import 'package:flutter/material.dart';

class AuthOptionsScreen extends StatelessWidget {
  const AuthOptionsScreen({
    super.key,
    required this.onCreateAccount,
    required this.onRegistered,
  });

  final VoidCallback onCreateAccount;
  final VoidCallback onRegistered;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'lib/images/logo.png',
              height: 150,
            ),
            Image.asset(
              'lib/images/cards.png',
              height: 200,
            ),
            const SizedBox(height: 16),
            const Divider(
              color: Colors.black,
              thickness: 0.5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'A ferramenta mais prática para te ajudar a gerir o seu dinheiro e alcançar seus objetivos!',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.5,
            ),
            const SizedBox(height: 32),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.indigoAccent),
              child: ListTile(
                  onTap: onCreateAccount,
                  title: const Text(
                    'Criar uma conta',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(
                    Icons.arrow_circle_right,
                    color: Colors.white,
                    size: 35,
                  )),
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: onRegistered,
              child: const Text('Já sou cadastrado'),
            )
          ],
        ),
      ),
    );
  }
}
