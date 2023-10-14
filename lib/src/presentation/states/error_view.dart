import 'package:blackjack/src/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final void Function() onPressed;
  const ErrorView({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Ops, algo deu errado, clique abaixo para tentar novamente!'),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onPressed: onPressed,
              label: "Tentar novamente",
            ),
          ],
        ),
      ),
    );
  }
}
