Welcome to Flutter! 🚀

 Flutter Architectue Overview

 Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. This lesson will give you a solid foundation in Flutter's architecture.

 What Makes Flutter Special?

 1, Reactive Programing

 Flutter follows reactive programimg paradigm where the UI automatically updates when the application state chnages. this means:

     1- No manual DOM Manipulation 
     2- Predictable UI Updates
     3- Less buoilerplates code
     4- Better performance

2- Widget Based Architecture

3- The widget Tree
  -Flutter apps are built as a tree of widget below is the example

  MaterialApp
├── Scaffold
    ├── AppBar
    │   └── Text("My App")
    └── Body
        ├── Column
        │   ├── Text("Welcome")
        │   └── ElevatedButton("Click Me")
        └── FloatingActionButton

How Flutter Renders UI

the three Trees
  1- Widget Tree: Your code structure
  2- Element Tree: Manages the lifecycle
  3- Render Tree: Handles layout and painting

  // Widget Tree (what you write)
Container(
  child: Text("Hello"),
)

// Flutter creates Element and RenderObject trees automatically


// The Build Process
 1- Build: Widgets described the UI
 2- Layout: Calculate size and position
 3- Paint: Draw pixels on Screen


// key concepts to remember 

   Hot Relaod
this makes chnages and see them instantly without losing app state:

// Stateless and Statefull widgets

  - Sateless: Immutable, like a function
  - Stateful: can change over time, has internal state.