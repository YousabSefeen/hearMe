import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sign_language/core/languages/controller/app_localizations.dart';

import '../../../core/languages/controller/language_provider.dart';

class HomeAppBarActions extends StatelessWidget {
  const HomeAppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return PopupMenuButton(
      popUpAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
        reverseDuration: const Duration(milliseconds: 400),
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'null',
          child: ListTile(
            title: Text(
              'languages'.translate(context),
              style: textTheme.titleMedium,
            ),
            subtitle: Container(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: 300,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.warning_amber, color: Colors.white, size: 22.sp),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        'warningMsg'.translate(context),
                        style: textTheme.titleSmall,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        PopupMenuItem(
          child: _customRadioListTile(
              languageCode: 'ar',
              title: 'arabic'.translate(context),
              context: context),
        ),
        PopupMenuItem(
          child: _customRadioListTile(
              languageCode: 'en',
              title: 'english'.translate(context),
              context: context),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(Icons.more_vert_outlined, color: Colors.white, size: 27.sp),
      ),
    );
  }

  _customRadioListTile({
    required String languageCode,
    required String title,
    required BuildContext context,
  }) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    final Size deviceSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: deviceSize.height * 0.07,
      child: RadioListTile(
        activeColor: Colors.greenAccent,
        value: languageCode,
        groupValue: languageProvider.languageCode,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        onChanged: (newLanguage) {
          Provider.of<LanguageProvider>(context, listen: false)
              .onChangeLanguage(newLanguage!);
          Navigator.pop(context);
        },
      ),
    );
  }
}
