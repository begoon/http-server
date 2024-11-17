import 'dart:convert';
import 'dart:io';

class Version {
  final String version;

  Version({required this.version});

  Map<String, dynamic> toJson() => {
        'version': version,
      };
}

Future<void> main() async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8000);
  print('Server listening on localhost:${server.port}');

  final version = Version(version: '1.0.0');

  await for (HttpRequest request in server) {
    if (request.method == 'GET' && request.uri.path == '/version') {
      request.response
        ..headers.contentType = ContentType.json
        ..write(jsonEncode(version))
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Not Found')
        ..close();
    }
  }
}
