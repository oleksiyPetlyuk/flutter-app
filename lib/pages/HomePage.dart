import 'dart:convert';
import 'package:ghflutter/pages/DetailPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../strings.dart';
import '../organization.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var _organizations = <Organization>[];

  int _since;

  bool _isLoading = true;

  _loadOrganizations() async {
    String dataUrl = "https://api.github.com/organizations";

    if (this._since != null) {
      dataUrl += "?since=${this._since}";
    }

    http.Response response = await http.get(dataUrl);

    setState(() {
      final organizationsJSON = json.decode(response.body);

      for (var organizationJSON in organizationsJSON) {
        final organization = Organization(
            id: organizationJSON['id'],
            name: organizationJSON['login'],
            avatarUrl: organizationJSON['avatar_url'],
            description: organizationJSON['description']);

        _organizations.add(organization);
      }

      _isLoading = false;
    });

    _since = _organizations.last.id;
  }

  Widget _buildRow(int i) {
    return Material(
      child: ListTile(
        title:
            Text("${_organizations[i].name}", style: TextStyle(fontSize: 18.0)),
        leading: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(_organizations[i].avatarUrl)),
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => DetailPage(
                        organization: _organizations[i],
                      )));
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadOrganizations();
  }

  Widget _showLoadingIndicator() {
    return Center(
      child: CupertinoActivityIndicator(),
    );
  }

  Widget _showData() {
    return CupertinoScrollbar(
      child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              _loadOrganizations();

              return true;
            }

            return false;
          },
          child: ListView.separated(
            itemCount: _organizations.length,
            itemBuilder: (BuildContext context, int position) {
              return _buildRow(position);
            },
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 1, color: Color.fromRGBO(232, 236, 241, 1)),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text(Strings.appTitle)),
        child: _isLoading ? _showLoadingIndicator() : _showData());
  }
}
