import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white, width: 3.0)),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    'LANDING PAGE',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      letterSpacing: 5.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // background
                      onPrimary: Colors.deepPurpleAccent, // foreground
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.register);
                    },
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(
                        letterSpacing: 3.0,
                        fontSize: 16.0
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.login);
                    },
                    child:const Text(
                        'SIGN IN',
                        style: TextStyle(
                          letterSpacing: 3.0,
                          fontSize: 16.0
                        ),
                      ),
                  ),
                ),
                const SizedBox(height: 20)
              ],
            )
          ],
        ),
      ),
    );
  }
}
