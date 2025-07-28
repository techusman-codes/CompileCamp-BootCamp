// Introduction:

// Basics Widgets: Text & Container
// Text and Container are the most fundamental widgets in Flutter.
// Master these, and you'll have a solid foundation for building any UI!

// The Text Widget
// The Text Widget displays a string of chracters with a single style.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text("Hello, Flutter!"))),

      // Text with Styling
      /* Text(
  //"Welcome to Flutter Bootcamp!",
  //style: TextStyle(
  
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    letterSpacing: 1.2,
  ),

  // AdvacE Text with Property 

  Text(
  "This is a long text that might overflow the available space in your UI layout",
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  textAlign: TextAlign.center,
  style: TextStyle(
    fontSize: 16,
    height: 1.5, // Line height
    fontFamily: 'Roboto',
  ),
)

// Text Alignment
// Left aligned (default)
Text("Left", textAlign: TextAlign.left)

// Center aligned
Text("Center", textAlign: TextAlign.center)

// Right aligned  
Text("Right", textAlign: TextAlign.right)

// Justified
Text("Justified text...", textAlign: TextAlign.justify)



// Overlaping handling
Text(
  "Very long text that needs to be handled properly",
  overflow: TextOverflow.ellipsis,  // Adds "..."
  // overflow: TextOverflow.clip,   // Cuts off
  // overflow: TextOverflow.fade,   // Fades out
)


)*/


/*The container Widgets









 */



    );
  }
}
