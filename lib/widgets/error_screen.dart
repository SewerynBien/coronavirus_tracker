import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String ERROR_TITLE = 'No Internet!',
      ERROR_MESSAGE = 'Reconnect, then press the refresh button.';

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.signal_wifi_off,
                  size: 200,
                  color: Colors.red[900],
                )),
            Text(
              ERROR_TITLE,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34,
                color: Colors.red[700],
                /* fontFamily: 'OpenSans Light' */
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
              child: Text(
                ERROR_MESSAGE,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.red[300],
                  /* fontFamily: 'OpenSans Light' */
                ),
              ),
            ),
          ],
        ));
  }
}
