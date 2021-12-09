import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';

class GetVersionAndBuildNumber extends StatelessWidget {
  const GetVersionAndBuildNumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: FutureBuilder(
        future: getVersion(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Text(
              'Versión ' + snapshot.data!,
              style: const TextStyle(color: Colors.grey),
            );
          } else {
            return const Text('');
          }
        },
      ),
    );
  }

  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    return version + '+' + buildNumber;
  }
}
