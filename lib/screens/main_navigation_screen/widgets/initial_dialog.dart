import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InitialDialog extends StatelessWidget {
  const InitialDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.popup_title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 23,
                color: Color(0xFF152937),
              ),
            ),
            Text(
              '2560',
              style: TextStyle(
                fontSize: 66,
                color: Color(0xFFA00022),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE10032),
                foregroundColor: Colors.white,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.popup_button,
                style: const TextStyle(fontSize: 24),
              ),
            )
          ],
        ),
      ),
    );
  }
}
