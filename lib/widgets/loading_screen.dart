import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  final String MESSAGE = 'Loading ...';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SpinKitFadingCircle(
                size: 120.0,
                itemBuilder: (_, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green,
                    ),
                  );
                },
              )),
          Text(
            MESSAGE,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              color: Colors.red,
              /* fontFamily: 'OpenSans Light' */
            ),
          ),
        ],
      ),
    );
  }
}
