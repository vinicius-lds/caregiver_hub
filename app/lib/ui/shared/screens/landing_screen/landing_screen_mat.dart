import 'package:caregiver_hub/ui/shared/constants/routes.dart';
import 'package:flutter/material.dart';

class LandingScreenMat extends StatelessWidget {
  const LandingScreenMat({Key? key}) : super(key: key);

  List<Widget> _buildLandingScreenColumnWidgetList({
    required BoxConstraints constraints,
    required double textScaleFactor,
  }) {
    return [
      _LandingScreenQuestionWidget(
        text: 'EU SOU UM...',
        textScaleFactor: textScaleFactor,
      ),
      const SizedBox(height: 20),
      _LandingScreenButtonWidget(
        text: 'EMPREGADOR',
        constraints: constraints,
        textScaleFactor: textScaleFactor,
        onPressed: () {},
      ),
      const SizedBox(height: 20),
      _LandingScreenButtonWidget(
        text: 'CUIDADOR',
        constraints: constraints,
        textScaleFactor: textScaleFactor,
        onPressed: () {},
      ),
    ];
  }

  List<Widget> _buildLandingScreenPreLoginColumnWidgetList({
    required BoxConstraints constraints,
    required double textScaleFactor,
  }) {
    return [
      _LandingScreenButtonWidget(
        text: 'CRIAR CONTA',
        constraints: constraints,
        textScaleFactor: textScaleFactor,
        onPressed: () {},
      ),
      const SizedBox(height: 20),
      _LandingScreenButtonWidget(
        text: 'ENTRAR',
        constraints: constraints,
        textScaleFactor: textScaleFactor,
        onPressed: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: constraints.maxHeight / 2.5,
                child: Image.asset('assets/images/logo.png'),
              ),
              Column(
                children: [
                  Text(
                    'EU SOU UM...',
                    style: TextStyle(
                      fontSize: 20 * textScaleFactor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.9,
                    child: ElevatedButton(
                      child: Text(
                        'EMPREGADOR',
                        style: TextStyle(
                          fontSize: 30 * textScaleFactor,
                        ),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.9,
                    child: ElevatedButton(
                      child: Text(
                        'CUIDADOR',
                        style: TextStyle(
                          fontSize: 30 * textScaleFactor,
                        ),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LandingScreenQuestionWidget extends StatelessWidget {
  final String text;
  final double textScaleFactor;

  const _LandingScreenQuestionWidget({
    Key? key,
    required this.text,
    required this.textScaleFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20 * textScaleFactor,
      ),
    );
  }
}

class _LandingScreenButtonWidget extends StatelessWidget {
  final String text;
  final BoxConstraints constraints;
  final double textScaleFactor;
  final void Function() onPressed;

  const _LandingScreenButtonWidget({
    Key? key,
    required this.text,
    required this.constraints,
    required this.textScaleFactor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: constraints.maxWidth * 0.9,
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 30 * textScaleFactor,
          ),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
