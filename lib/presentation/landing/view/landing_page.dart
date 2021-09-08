import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.indigoAccent,
              Colors.indigo.shade900,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Text(
                            'DJ',
                            style: TextStyle(
                                color: Colors.indigo.shade900,
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold),
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
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange.shade400, // background
                        onPrimary: Colors.white, // foreground
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(10.0),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.register);
                      },
                      child: const Text(
                        'GET STARTED',
                        style: TextStyle(letterSpacing: 1.5, fontSize: 20.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.login);
                      },
                      child: const Text(
                        'I ALREADY HAVE AN ACCOUNT',
                        style: TextStyle(letterSpacing: 1.5, fontSize: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
