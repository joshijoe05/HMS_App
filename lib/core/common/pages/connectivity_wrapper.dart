import 'package:flutter/material.dart';
import 'package:hms_app/core/common/provider/network_provider.dart';
import 'package:hms_app/core/constants/assets.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ConnectivityWrapper extends StatelessWidget {
  final Widget child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, data, _) {
        return data.isOnline
            ? child
            : Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(Assets.noInternet),
                        Text(
                          "Lost Connection !",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        20.height,
                        Text(
                          "Whoops.. No Internet Connection Found ! Please Check your connection",
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
