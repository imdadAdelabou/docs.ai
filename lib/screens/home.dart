import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/models/document_model.dart';
import 'package:google_clone/models/error_model.dart';
import 'package:google_clone/models/user.dart';
import 'package:google_clone/repository/auth_repository.dart';
import 'package:google_clone/repository/document_repository.dart';
import 'package:google_clone/screens/document/widgets/document_card.dart';
import 'package:google_clone/screens/verify_if_user_not_null.dart';
import 'package:google_clone/widgets/custom_app_bar.dart';
import 'package:google_clone/widgets/user_data.display.dart';

/// Contains the visual aspect of the home screen
class Home extends ConsumerWidget {
  /// Creates a [Home] widget
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserModel? user = ref.watch(userProvider);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: VerifyIfUserNotNull(
        child: Column(
          children: <Widget>[
            if (user != null)
              UserDataDisplay(
                userModel: user,
              ),
            FutureBuilder<ErrorModel>(
              future:
                  // ignore: discarded_futures
                  ref.read(documentRepositoryProvider).meDocument(user!.token),
              builder:
                  (BuildContext context, AsyncSnapshot<ErrorModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return const Text('Error');
                }

                if (snapshot.data != null && snapshot.data!.error != null) {
                  return Text(snapshot.data!.error!);
                }
                final List<DocumentModel> documents =
                    snapshot.data!.data as List<DocumentModel>;

                return Center(
                  child: SizedBox(
                    width: 600,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, int index) =>
                          DocumentCard(
                        document: documents[index],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
