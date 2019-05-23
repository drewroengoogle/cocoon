// Copyright (c) 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_web/material.dart';

import '../models/providers.dart';
import '../models/github_status.dart';

class InfrastructureDetails extends StatelessWidget {
  const InfrastructureDetails();

  @override
  Widget build(BuildContext context) {
    CircleAvatar cirrusLogo = CircleAvatar(
      child: Image.network('https://avatars2.githubusercontent.com/ml/953?s=28'),
      backgroundColor: const Color(0xFF212121),
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: IconTheme(data: Theme.of(context).iconTheme.copyWith(size: 28.0), child: Icon(Icons.build)),
              title: const Text('Infrastructure'),
            ),
            ListTile(
              leading: cirrusLogo,
              title: const Text('packages'),
              trailing: Image.network('https://api.cirrus-ci.com/github/flutter/packages.svg?branch=master', semanticLabel: 'Packages Cirrus CI Status'),
            ),
            ListTile(
              leading: cirrusLogo,
              title: const Text('website'),
              trailing: Image.network('https://api.cirrus-ci.com/github/flutter/website.svg?branch=master', semanticLabel: 'Website Cirrus CI Status'),
            ),
            ListTile(
              leading: cirrusLogo,
              title: const Text('flutter_markdown'),
              trailing: Image.network('https://api.cirrus-ci.com/github/flutter/flutter_markdown.svg?branch=master', semanticLabel: 'Flutter Markdown Cirrus CI Status'),
            ),
            ModelBinding<GithubStatus>(
              initialModel: const GithubStatus(),
              child: ListTile(
                leading: CircleAvatar(
                  child: Image.network('https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png'),
                ),
                title: const Text('Github'),
                trailing: const _GithubStatusIndicator(),
              ),
            ),
          ]
        ),
      ),
    );
  }
}

class _GithubStatusIndicator extends StatelessWidget {
  const _GithubStatusIndicator();

  @override
  Widget build(BuildContext context) {
    GithubStatus githubStatus = ModelBinding.of<GithubStatus>(context);
    IconData icon;
    Color backgroundColor;
    switch (githubStatus.indicator) {
      case 'none':
        icon = Icons.check;
        backgroundColor = Colors.greenAccent;
        break;
      case 'minor':
        icon = Icons.warning;
        backgroundColor = Colors.amberAccent;
        break;
      case 'major':
        icon = Icons.error;
        backgroundColor = Colors.orangeAccent;
        break;
      case 'critical':
        icon = Icons.error;
        backgroundColor = Colors.redAccent;
        break;
      default:
        icon = Icons.help_outline;
        backgroundColor = Colors.grey;
    }
    return Semantics(
      child: RefreshGithubStatus(
        child: Chip(
          avatar: Icon(icon, size: 18.0),
          backgroundColor: backgroundColor,
          labelPadding: const EdgeInsets.fromLTRB(3.0, 3.0, 8.0, 3.0),
          label: Text(githubStatus.status ?? 'Unknown')
        ),
      ),
      hint: 'Github Status',
    );
  }
}