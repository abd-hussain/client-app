import 'package:client_app/screens/archive/archive_bloc.dart';
import 'package:client_app/screens/archive/widgets/archive_tile_view.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  final bloc = ArchiveBloc();
  @override
  Widget build(BuildContext context) {
    //TODO : ArchiveScreen
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.archive),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Lottie.asset('assets/lottie/76734-shield-icon.zip', height: 150),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomText(
                title: AppLocalizations.of(context)!.archivepagetitle,
                fontSize: 16,
                textAlign: TextAlign.center,
                textColor: const Color(0xff554d56),
                maxLins: 5,
              ),
            ),
            Expanded(
              child: bloc.listOfArchive.isNotEmpty
                  ? ListView.builder(
                      itemCount: bloc.listOfArchive.length,
                      itemBuilder: (context, index) {
                        return ArchiveTileView(
                          onTap: (p0) {},
                        );
                      },
                    )
                  : Center(
                      child: CustomText(
                        title: AppLocalizations.of(context)!.noitem,
                        fontSize: 16,
                        textColor: const Color(0xff554d56),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
