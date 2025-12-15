import 'package:clone_whatsapp_round34/generated/l10n.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable helper to show the country code picker.
///
/// Usage:
/// ```dart
/// showCountryPickerDialog(context, onSelect: (country) { /* ... */ });
/// ```
void showCountryPickerDialog(
  BuildContext context, {
  required ValueChanged<Country> onSelect,
  List<String>? favorite,
  double? bottomSheetHeight,
}) {
  final theme = Theme.of(context);

  return showCountryPicker(
    context: context,
    showPhoneCode: true,
    favorite: favorite ?? const ['EG', 'SA', 'AE'],  
    countryListTheme: CountryListThemeData(
      bottomSheetHeight: bottomSheetHeight ?? 600.h,
      backgroundColor: theme.scaffoldBackgroundColor,
      
      flagSize: 25.sp,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
      
      textStyle: theme.textTheme.titleMedium, 
      
      searchTextStyle: theme.textTheme.bodyLarge,

      inputDecoration: InputDecoration(
        labelText: S.of(context).search_label,
        hintText: S.of(context).search_hint,

        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: .6),
        ),
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: .4),
        ),

        prefixIcon: Icon(
          Icons.language,

          color: theme.colorScheme.primary,
        ),


        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.onSurface.withValues(alpha: .2),
          ),
        ),

        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    ),
    onSelect: onSelect,
  );
}