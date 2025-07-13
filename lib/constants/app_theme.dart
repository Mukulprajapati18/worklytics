import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppConstants.primaryColor,
        brightness: Brightness.light,
      ),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppConstants.heading6.copyWith(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      // Card Theme
      // cardTheme: CardTheme(
      //   color: AppConstants.cardColor,
      //   elevation: 2,
      //   shadowColor: Colors.black.withOpacity(0.1),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(AppConstants.radiusL),
      //   ),
      //   margin: const EdgeInsets.all(AppConstants.paddingS),
      // ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: AppConstants.primaryColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          minimumSize: const Size(double.infinity, AppConstants.buttonHeightM),
          textStyle: AppConstants.button,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingL,
            vertical: AppConstants.paddingM,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppConstants.primaryColor,
          side: const BorderSide(color: AppConstants.primaryColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          minimumSize: const Size(double.infinity, AppConstants.buttonHeightM),
          textStyle: AppConstants.button.copyWith(color: AppConstants.primaryColor),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingL,
            vertical: AppConstants.paddingM,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConstants.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          minimumSize: const Size(double.infinity, AppConstants.buttonHeightM),
          textStyle: AppConstants.button.copyWith(color: AppConstants.primaryColor),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingL,
            vertical: AppConstants.paddingM,
          ),
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: CircleBorder(),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppConstants.backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: BorderSide(color: AppConstants.textHintColor.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppConstants.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppConstants.errorColor, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppConstants.errorColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingM,
        ),
        hintStyle: AppConstants.body2.copyWith(color: AppConstants.textHintColor),
        labelStyle: AppConstants.body2.copyWith(color: AppConstants.textSecondaryColor),
        errorStyle: AppConstants.caption.copyWith(color: AppConstants.errorColor),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppConstants.cardColor,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: AppConstants.textSecondaryColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
      ),
      
      // Tab Bar Theme
      // tabBarTheme: const TabBarTheme(
      //   labelColor: AppConstants.primaryColor,
      //   unselectedLabelColor: AppConstants.textSecondaryColor,
      //   indicatorColor: AppConstants.primaryColor,
      //   indicatorSize: TabBarIndicatorSize.tab,
      //   labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      //   unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      // ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppConstants.backgroundColor,
        selectedColor: AppConstants.primaryLightColor,
        disabledColor: AppConstants.textHintColor.withOpacity(0.3),
        labelStyle: AppConstants.body2,
        secondaryLabelStyle: AppConstants.body2.copyWith(color: AppConstants.primaryColor),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
        ),
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppConstants.textHintColor,
        thickness: 1,
        space: 1,
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppConstants.textSecondaryColor,
        size: AppConstants.iconSizeM,
      ),
      
      // Primary Icon Theme
      primaryIconTheme: const IconThemeData(
        color: AppConstants.primaryColor,
        size: AppConstants.iconSizeM,
      ),
      
      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppConstants.heading1,
        displayMedium: AppConstants.heading2,
        displaySmall: AppConstants.heading3,
        headlineLarge: AppConstants.heading4,
        headlineMedium: AppConstants.heading5,
        headlineSmall: AppConstants.heading6,
        titleLarge: AppConstants.heading5,
        titleMedium: AppConstants.heading6,
        titleSmall: AppConstants.body2.copyWith(fontWeight: FontWeight.w600),
        bodyLarge: AppConstants.body1,
        bodyMedium: AppConstants.body2,
        labelLarge: AppConstants.button,
        labelMedium: AppConstants.body2,
        labelSmall: AppConstants.caption,
      ),
      
      // Scaffold Background Color
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      
      // Dialog Theme
      // dialogTheme: DialogTheme(
      //   backgroundColor: AppConstants.cardColor,
      //   elevation: 8,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(AppConstants.radiusL),
      //   ),
      //   titleTextStyle: AppConstants.heading5,
      //   contentTextStyle: AppConstants.body2,
      // ),
      
      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppConstants.textPrimaryColor,
        contentTextStyle: AppConstants.body2.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),
      
      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppConstants.cardColor,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.radiusL),
          ),
        ),
      ),
      
      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingS,
        ),
        titleTextStyle: AppConstants.body1,
        subtitleTextStyle: AppConstants.body2,
        leadingAndTrailingTextStyle: AppConstants.caption,
        iconColor: AppConstants.textSecondaryColor,
        textColor: AppConstants.textPrimaryColor,
        tileColor: AppConstants.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
      ),
      
      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppConstants.primaryColor;
          }
          return AppConstants.textSecondaryColor;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppConstants.primaryColor.withOpacity(0.5);
          }
          return AppConstants.textHintColor.withOpacity(0.3);
        }),
      ),
      
      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppConstants.primaryColor;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(Colors.white),
        side: const BorderSide(color: AppConstants.textSecondaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusS),
        ),
      ),
      
      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppConstants.primaryColor;
          }
          return AppConstants.textSecondaryColor;
        }),
      ),
      
      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: AppConstants.primaryColor,
        inactiveTrackColor: AppConstants.textHintColor.withOpacity(0.3),
        thumbColor: AppConstants.primaryColor,
        overlayColor: AppConstants.primaryColor.withOpacity(0.2),
        valueIndicatorColor: AppConstants.primaryColor,
        valueIndicatorTextStyle: AppConstants.caption.copyWith(color: Colors.white),
      ),
      
      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppConstants.primaryColor,
        linearTrackColor: AppConstants.textHintColor,
        circularTrackColor: AppConstants.textHintColor,
      ),
      
      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppConstants.textPrimaryColor,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
        textStyle: AppConstants.caption.copyWith(color: Colors.white),
        waitDuration: const Duration(milliseconds: 500),
        showDuration: const Duration(seconds: 2),
      ),
      
      // Popup Menu Theme
      popupMenuTheme: PopupMenuThemeData(
        color: AppConstants.cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
        textStyle: AppConstants.body2,
      ),
      
      // Drawer Theme
      drawerTheme: DrawerThemeData(
        backgroundColor: AppConstants.cardColor,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppConstants.radiusL),
            bottomRight: Radius.circular(AppConstants.radiusL),
          ),
        ),
      ),
      
      // Expansion Tile Theme
      expansionTileTheme: const ExpansionTileThemeData(
        backgroundColor: AppConstants.cardColor,
        collapsedBackgroundColor: AppConstants.backgroundColor,
        textColor: AppConstants.textPrimaryColor,
        iconColor: AppConstants.textSecondaryColor,
        collapsedTextColor: AppConstants.textSecondaryColor,
        collapsedIconColor: AppConstants.textSecondaryColor,
      ),
      
      // Data Table Theme
      dataTableTheme: DataTableThemeData(
        headingTextStyle: AppConstants.heading6,
        dataTextStyle: AppConstants.body2,
        headingRowColor: MaterialStateProperty.all(AppConstants.backgroundColor),
        dataRowColor: MaterialStateProperty.all(AppConstants.cardColor),
        dividerThickness: 1,
        columnSpacing: AppConstants.paddingL,
        horizontalMargin: AppConstants.paddingM,
      ),
      
      // Pagination Theme
      // paginationTheme: const PaginationThemeData(
      //   color: AppConstants.primaryColor,
      //   backgroundColor: AppConstants.backgroundColor,
      // ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppConstants.primaryColor,
        brightness: Brightness.dark,
      ),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppConstants.primaryDarkColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppConstants.heading6.copyWith(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      // Card Theme
      // cardTheme: CardTheme(
      //   color: const Color(0xFF1E1E1E),
      //   elevation: 2,
      //   shadowColor: Colors.black.withOpacity(0.3),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(AppConstants.radiusL),
      //   ),
      //   margin: const EdgeInsets.all(AppConstants.paddingS),
      // ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: AppConstants.primaryColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          minimumSize: const Size(double.infinity, AppConstants.buttonHeightM),
          textStyle: AppConstants.button,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingL,
            vertical: AppConstants.paddingM,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2A2A2A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppConstants.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppConstants.errorColor, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppConstants.errorColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingM,
        ),
        hintStyle: AppConstants.body2.copyWith(color: Colors.grey),
        labelStyle: AppConstants.body2.copyWith(color: Colors.grey),
        errorStyle: AppConstants.caption.copyWith(color: AppConstants.errorColor),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
      ),
      
      // Scaffold Background Color
      scaffoldBackgroundColor: const Color(0xFF121212),
      
      // Dialog Theme
      // dialogTheme: DialogTheme(
      //   backgroundColor: const Color(0xFF1E1E1E),
      //   elevation: 8,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(AppConstants.radiusL),
      //   ),
      //   titleTextStyle: AppConstants.heading5.copyWith(color: Colors.white),
      //   contentTextStyle: AppConstants.body2.copyWith(color: Colors.white),
      // ),
      
      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingS,
        ),
        titleTextStyle: AppConstants.body1.copyWith(color: Colors.white),
        subtitleTextStyle: AppConstants.body2.copyWith(color: Colors.grey),
        leadingAndTrailingTextStyle: AppConstants.caption.copyWith(color: Colors.grey),
        iconColor: Colors.grey,
        textColor: Colors.white,
        tileColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
      ),
      
      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppConstants.heading1.copyWith(color: Colors.white),
        displayMedium: AppConstants.heading2.copyWith(color: Colors.white),
        displaySmall: AppConstants.heading3.copyWith(color: Colors.white),
        headlineLarge: AppConstants.heading4.copyWith(color: Colors.white),
        headlineMedium: AppConstants.heading5.copyWith(color: Colors.white),
        headlineSmall: AppConstants.heading6.copyWith(color: Colors.white),
        titleLarge: AppConstants.heading5.copyWith(color: Colors.white),
        titleMedium: AppConstants.heading6.copyWith(color: Colors.white),
        titleSmall: AppConstants.body2.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: AppConstants.body1.copyWith(color: Colors.white),
        bodyMedium: AppConstants.body2.copyWith(color: Colors.white),
        labelLarge: AppConstants.button,
        labelMedium: AppConstants.body2.copyWith(color: Colors.white),
        labelSmall: AppConstants.caption.copyWith(color: Colors.grey),
      ),
    );
  }
} 