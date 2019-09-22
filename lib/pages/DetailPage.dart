import 'package:flutter/cupertino.dart';
import '../organization.dart';
import 'package:meta/meta.dart';
import '../strings.dart';

class DetailPage extends StatelessWidget {
  final Organization organization;

  DetailPage({@required this.organization});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar:
            CupertinoNavigationBar(middle: Text(Strings.detailPageTitle)),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                child: Image(
                  image: NetworkImage(organization.avatarUrl),
                ),
              ),
            ),
            Text(
              organization.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(organization.description ?? ''),
          ],
        ));
  }
}
