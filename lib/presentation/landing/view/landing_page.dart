import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF203f81),
                Color(0xFF576cd6),
                Color(0xFF4f67d8),
                Color(0xFF203f81),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0,),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: const Text(
                              'DJ',
                              style: TextStyle(
                                color: Color(0xFF576cd6),
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            children: const [
                              Text(
                                'Dream',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Journal',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 3.0,
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .75,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.buttonMain, // background
                          onPrimary: Colors.white, // foreground
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.all(16.0),
                          shadowColor: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.register);
                        },
                        child: const Text(
                          'Get Started',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .75,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.login);
                        },
                        child: const Center(
                          child: Text(
                            'I ALREADY HAVE AN ACCOUNT',
                            style: TextStyle(letterSpacing: 1.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
