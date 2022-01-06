import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreenMat extends StatelessWidget {
  const LandingScreenMat({Key? key}) : super(key: key);

  void _pushCaregiverLogin(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false).isCaregiver = true;
    Navigator.of(context).pushNamed(Routes.LOGIN_SCREEN);
  }

  void _pushEmployerLogin(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false).isCaregiver = false;
    Navigator.of(context).pushNamed(Routes.LOGIN_SCREEN);
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: LayoutBuilder(
        builder: (bContext, constraints) => Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05,
                    vertical: constraints.maxHeight * 0.05,
                  ),
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset('assets/images/logo.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'ENTAR COMO...',
                    style: TextStyle(
                      fontSize: 20 * textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: constraints.maxWidth * 0.9,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ElevatedButton(
                    child: Text(
                      'EMPREGADOR',
                      style: TextStyle(
                        fontSize: 20 * textScaleFactor,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                    onPressed: () => _pushEmployerLogin(bContext),
                  ),
                ),
                Container(
                  width: constraints.maxWidth * 0.9,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ElevatedButton(
                    child: Text(
                      'CUIDADOR',
                      style: TextStyle(
                        fontSize: 20 * textScaleFactor,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                    onPressed: () => _pushCaregiverLogin(bContext),
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
