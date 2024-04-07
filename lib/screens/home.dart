import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/models/document_model.dart';
import 'package:google_clone/models/error_model.dart';
import 'package:google_clone/models/user.dart';
import 'package:google_clone/repository/auth_repository.dart';
import 'package:google_clone/repository/document_repository.dart';
import 'package:google_clone/screens/document/widgets/document_card.dart';
import 'package:google_clone/screens/place_holder_for_empty_document.dart';
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
        child: Center(
          child: Column(
            children: <Widget>[
              if (user != null)
                UserDataDisplay(
                  userModel: user,
                ),
              FutureBuilder<ErrorModel>(
                future: ref
                    .read(documentRepositoryProvider)
                    // ignore: discarded_futures
                    .meDocument(user!.token),
                builder:
                    (BuildContext context, AsyncSnapshot<ErrorModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return const Text('Error');
                  }

                  if (snapshot.data != null && snapshot.data!.error != null) {
                    return const PlaceHolderForEmptyDocument();
                  }
                  final List<DocumentModel> documents =
                      snapshot.data!.data as List<DocumentModel>;

                  // return DocumentCard(
                  //   document: documents[0],
                  // );

                  return LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth > 480) {
                      return SizedBox(
                        width: 208 * 3,
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: documents.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return DocumentCard(
                              document: documents[index],
                            );
                          },
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DocumentCard(
                          document: documents[index],
                        );
                      },
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
