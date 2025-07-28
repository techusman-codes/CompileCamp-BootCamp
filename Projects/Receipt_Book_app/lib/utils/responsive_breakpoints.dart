class ResponsiveBreakpoints {
  static const double mobile = 600;     // 0-599: Mobile
  static const double tablet = 1200;    // 600-1199: Tablet
  // 1200+: Desktop
  
  static bool isMobile(double width) => width < mobile;
  static bool isTablet(double width) => width >= mobile && width < tablet;
  static bool isDesktop(double width) => width >= tablet;
  
  // Helper for getting columns based on width
  static int getRecipeColumns(double width) {
    if (width < 400) return 1;      // Small mobile
    if (width < 600) return 2;      // Large mobile
    if (width < 900) return 3;      // Small tablet
    if (width < 1200) return 4;     // Large tablet
    return 5;                       // Desktop
  }
}
