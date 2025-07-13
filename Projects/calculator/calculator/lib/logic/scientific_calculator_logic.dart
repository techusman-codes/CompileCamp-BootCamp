// Scientific calculator functions
import 'dart:math' as math;

import 'package:calculator/Models/calculatorstate.dart';
import 'package:calculator/logic/calculatorlogic.dart';

class ScientificCalculator extends CalculatorLogic {
  static CalculatorState handleScientificFunction(CalculatorState state, String function) {
    final current = state.currentValue ?? 0;
    double? result;
    
    switch (function) {
      case "sin":
        result = math.sin(current * math.pi / 180); // Convert to radians
        break;
      case "cos":
        result = math.cos(current * math.pi / 180);
        break;
      case "tan":
        result = math.tan(current * math.pi / 180);
        break;
      case "log":
        if (current <= 0) return state.copyWith(display: "Error");
        result = math.log(current) / math.ln10;
        break;
      case "ln":
        if (current <= 0) return state.copyWith(display: "Error");
        result = math.log(current);
        break;
      case "x²":
        result = current * current;
        break;
      case "x³":
        result = current * current * current;
        break;
      case "1/x":
        if (current == 0) return state.copyWith(display: "Error");
        result = 1 / current;
        break;
    }
    
    if (result == null) return state;
    
    return state.copyWith(
      display: _formatDisplay(result),
      currentValue: result,
    );
  }

  static String _formatDisplay(num value) {
    if (value.isNaN || value.isInfinite) return "Error";
    // Show up to 8 decimal places, remove trailing zeros
    return value.toStringAsFixed(8).replaceAll(RegExp(r"([.]*0+)$"), "");
  }
}
