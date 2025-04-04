import 'package:flutter/material.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';
import 'another_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            color: Colors.purple, // Set background color to purple
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Column(
              children: [
                Flexible(
                    flex: 8,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child: Center(
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(children: [
                                TextSpan(
                                    text: "Welcome to sans un mot!\n\n",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    )),
                                TextSpan(
                                    text:
                                        "Discover the power of language and communication.\n",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ))
                              ]))),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: [
                            Expanded(
                                child: WelcomeButton(
                              btnText: "Invite Mode",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AnotherScreen()),
                                );
                              },
                              color: Colors.blue,
                              textColor: Colors.white,
                            )),
                            Expanded(
                                child: WelcomeButton(
                              btnText: "Sign Up",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()),
                                );
                              },
                              color: Colors.transparent,
                              textColor: Colors.black,
                            )),
                            Expanded(
                                child: WelcomeButton(
                              btnText: "Log In",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInPage()),
                                );
                              },
                              color: Colors.white,
                              textColor: Colors.green,
                            )),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;

  const WelcomeButton({
    required this.btnText,
    required this.onTap,
    required this.color,
    required this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black12),
        ),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
