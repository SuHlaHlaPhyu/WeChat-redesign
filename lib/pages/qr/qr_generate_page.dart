import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wechat_redesign/blocs/qr_bloc.dart';
import 'package:wechat_redesign/pages/qr/qr_scan_page.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';

class QRGeneratePage extends StatelessWidget {
  const QRGeneratePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QRBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 28.0,
                color: ADD_ICON_COLOR,
              ),
            ),
          ),
          title: Center(
            child: Text(
              "QR Code",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: APP_TITLE_COLOR,
                  fontSize: TEXT_REGULAR_2XX,
                ),
              ),
            ),
          ),
        ),
        body: const GeneratedQRCodeView(),
        floatingActionButton: const QRScannerView(),
      ),
    );
  }
}

class QRScannerView extends StatelessWidget {
  const QRScannerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const QRScanPage(),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: SIGN_UP_COLOR,
          borderRadius: BorderRadius.circular(
            50.0,
          ),
        ),
        height: 70.0,
        width: 70.0,
        child: const Icon(
          Icons.qr_code_scanner_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

class GeneratedQRCodeView extends StatelessWidget {
  const GeneratedQRCodeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QRBloc>(
      builder: (context, bloc, child) => Center(
        child: QrImage(
          data: bloc.currentUser?.qrCode ?? "",
          version: QrVersions.auto,
          size: 250.0,
        ),
      ),
    );
  }
}
