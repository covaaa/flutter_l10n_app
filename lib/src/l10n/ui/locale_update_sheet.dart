import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_l10n_app/src/l10n/domain/locale.dart';
import 'package:flutter_l10n_app/src/l10n/state/readers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' as fpdart;

class LocaleUpdateSheet extends ConsumerStatefulWidget {
  const LocaleUpdateSheet(this.locale, {super.key});

  final SealedLocale locale;

  static Future<void> show(
    BuildContext context, {
    required SealedLocale locale,
  }) {
    final theme = Theme.of(context);
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      builder: (context) => LocaleUpdateSheet(locale),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LocaleUpdateSheetState();
  }
}

class _LocaleUpdateSheetState extends ConsumerState<LocaleUpdateSheet> {
  late fpdart.Option<SealedLocale> locale;

  @override
  void initState() {
    super.initState();
    locale = fpdart.some(widget.locale);
  }

  @override
  Widget build(BuildContext context) {
    const localeEn = LocaleEn();
    const localeJa = LocaleJa();

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final titleLarge = textTheme.titleLarge;

    void onChanged(SealedLocale? newLocale) {
      return setState(() => locale = fpdart.optionOf(newLocale));
    }

    void readLocale() {
      locale.map(
        (some) {
          final reader = ref.read(readLocaleProvider.notifier);
          some.when(en: reader.en, ja: reader.ja);
          return Navigator.pop(context);
        },
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            scrolledUnderElevation: 0,
            titleTextStyle: titleLarge,
            title: locale.map((some) {
              return Text(lookupL10n(some).language);
            }).toNullable(),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                RadioListTile<SealedLocale>(
                  key: localeEn.key,
                  value: localeEn,
                  onChanged: onChanged,
                  groupValue: locale.toNullable(),
                  title: Text(lookupL10n(localeEn).locale),
                ),
                RadioListTile<SealedLocale>(
                  key: localeJa.key,
                  value: localeJa,
                  onChanged: onChanged,
                  groupValue: locale.toNullable(),
                  title: Text(lookupL10n(localeJa).locale),
                ),
                Center(
                  child: FilledButton.tonal(
                    onPressed: readLocale,
                    child: locale.map((some) {
                      return Text(lookupL10n(some).done);
                    }).toNullable(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
