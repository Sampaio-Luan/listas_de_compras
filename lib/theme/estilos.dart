import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Estilos {
  TextStyle tipofonte = GoogleFonts.getFont('Pridi');

  tituloColor(context, {required String tamanho}) {
    switch (tamanho) {
      case 'p':
        return TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: Theme.of(context).textTheme.titleSmall!.fontSize! * 1.35,
          fontFamily: tipofonte.fontFamily,
        );
      case 'm':
        return TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize! * 1.35,
          fontFamily: tipofonte.fontFamily,
        );
      case 'g':
        return TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: Theme.of(context).textTheme.titleLarge!.fontSize! * 1.35,
          fontFamily: tipofonte.fontFamily,
        );
      default:
    }
  }

  titulo(context, {required String tamanho}) {
    switch (tamanho) {
      case 'p':
        return TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: Theme.of(context).textTheme.titleSmall!.fontSize! * 1.35,
          fontFamily: tipofonte.fontFamily,
        );
      case 'm':
        return TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize! * 1.35,
          fontFamily: tipofonte.fontFamily,
        );
      case 'g':
        return TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: Theme.of(context).textTheme.titleLarge!.fontSize! * 1.35,
          fontFamily: tipofonte.fontFamily,
        );
      default:
    }
  }

  corpo(context, {required String tamanho}) {
    switch (tamanho) {
      case 'p':
        return TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: Theme.of(context).textTheme.bodySmall!.fontSize! * 1.35,
        );
      case 'm':
        return TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize! * 1.35,
        );
      case 'g':
        return TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize! * 1.35,
        );
      default:
    }
  }

  corpoColor(context, {required String tamanho}) {
    switch (tamanho) {
      case 'p':
        return TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: Theme.of(context).textTheme.bodySmall!.fontSize! * 1.35,
        );
      case 'm':
        return TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize! * 1.35,
        );
      case 'g':
        return TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize! * 1.35,
        );
      default:
    }
  }

  labelColor(context, {required String tamanho}) {
    switch (tamanho) {
      case 'p':
        return TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: Theme.of(context).textTheme.labelSmall!.fontSize! * 1.35,
        );
      case 'm':
        return TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: Theme.of(context).textTheme.labelMedium!.fontSize! * 1.35,
        );
      case 'g':
        return TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: Theme.of(context).textTheme.labelLarge!.fontSize! * 1.35,
        );
      default:
    }
  }

  label(context, {required String tamanho}) {
    switch (tamanho) {
      case 'p':
        return TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: Theme.of(context).textTheme.labelSmall!.fontSize! * 1.35,
        );
      case 'm':
        return TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: Theme.of(context).textTheme.labelMedium!.fontSize! * 1.35,
        );
      case 'g':
        return TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: Theme.of(context).textTheme.labelLarge!.fontSize! * 1.35,
        );
      default:
    }
  }
}
