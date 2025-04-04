import 'package:flutter/material.dart';
import 'another_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple, // Set background color to purple
      body: Stack(
        children: [
          // Title at the top center
          Positioned(
            top: 40, // Margin from the top
            left: 0,
            right: 0,
            child: Text(
              "Sans un Mot",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          // Zone opaque for text and button
          Positioned(
            bottom: 0, // Adjust to be at the bottom of the screen
            left: 0,
            right: 0,
            child: Container(
              height: 250, // Height of the opaque zone
              color: Colors.black.withOpacity(0.5), // Black color with opacity
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center content vertically
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center horizontally
                children: [
                  Text(
                    "Bienvenue dans votre espace de communication !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Une application conçue pour faciliter votre interaction avec le monde.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the main page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnotherScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 99, 77, 137), // Button color
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Commencer",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Add navigation logic to other screens here if needed
