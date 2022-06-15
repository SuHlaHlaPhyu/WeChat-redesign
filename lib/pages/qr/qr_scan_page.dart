import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wechat_redesign/blocs/qr_scan_bloc.dart';
import 'package:wechat_redesign/pages/chatting/chat_history_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/viewitems/loading_view.dart';

import '../../resources/dimens.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QRScanBloc(),
      child: Selector<QRScanBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, bloc) => Stack(
          children: [
            Scaffold(
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
                    "QR Scan",
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
              body: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: _buildQrView(context),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: MARGIN_LARGE,
                        ),
                        AddToContactView(result: result),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                color: Colors.black12,
                child: const Center(
                  child: LoadingView(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddToContactView extends StatelessWidget {
  const AddToContactView({
    Key? key,
    required this.result,
  }) : super(key: key);

  final Barcode? result;

  @override
  Widget build(BuildContext context) {
    return Consumer<QRScanBloc>(
      builder: (context, bloc, child) => GestureDetector(
        onTap: () {
          bloc.addToContact(result?.code ?? "").then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatHistoryPage(
                      index: 1,
                    ),
                  ),
                ),
              );
        },
        child: Visibility(
          visible: result != null,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 40,
            width: 220,
            decoration: BoxDecoration(
              color: SIGN_UP_COLOR,
              borderRadius: BorderRadius.circular(
                5.0,
              ),
            ),
            child: Center(
              child: Text(
                "ADD to Contact",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: MARGIN_MEDIUM_2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
