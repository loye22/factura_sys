import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:html' as html;

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class staticVar {
  static TextStyle t1 = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: Color.fromRGBO(114, 128, 150, 1));

  static DataColumn Dc(String name) => DataColumn(
        label: Center(
          child: Text(
            name,
            style: staticVar.t1,
          ),
        ),
      );

  static TextStyle titleStyle = TextStyle(
      fontFamily: 'louie',
      fontWeight: FontWeight.w600,
      fontSize: 24,
      color: Color.fromRGBO(20, 53, 96, 1));

  static TextStyle subtitleStyle1 = TextStyle(
      fontFamily: 'louie',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Color.fromRGBO(20, 53, 96, 1));

  static TextStyle tableTitle = TextStyle(
      fontFamily: 'louie',
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: Color.fromRGBO(20, 53, 96, 1));

  static TextStyle subtitleStyle2 = TextStyle(
      fontFamily: 'louie',
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: Color.fromRGBO(114, 128, 150, 1));
  static TextStyle subtitleStyle3 = TextStyle(
      fontFamily: 'louie',
      fontWeight: FontWeight.w600,
      fontSize: 15,
      color: Color.fromRGBO(114, 128, 150, 1));

  static TextStyle subtitleStyle4Warrining = TextStyle(
      fontFamily: 'louie',
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: Colors.red);

  static TextStyle subtitleStyle4Warrining2 = TextStyle(
      fontFamily: 'louie',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.red);

  static TextStyle subtitleStyle4 = TextStyle(
      fontFamily: 'louie',
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: Colors.black);

  static TextStyle subtitleStyle5 = TextStyle(
      fontFamily: 'louie',
      fontWeight: FontWeight.w600,
      fontSize: 24,
      color: Color.fromRGBO(20, 53, 96, 1));

  static TextStyle subtitleStyle6 = TextStyle(
      fontFamily: 'louie',
      fontWeight: FontWeight.w600,
      fontSize: 15,
      color: Colors.black);

  static Color buttonColor = Color.fromRGBO(20, 53, 96, 1);

  static void showOverlay({
    required BuildContext ctx,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    showModalBottomSheet(
      context: ctx,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: onEdit,
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: onDelete,
              ),
            ],
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
    );
  }

  static double golobalWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.95;

  static double golobalHigth(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.95;

  static double fullWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double fullhigth(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static Color c1 = Color.fromRGBO(33, 103, 199, 1);

  static Widget divider() => Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey, width: .5)),
      );

  static Widget loading(
          {double size = 100,
          Color colors = const Color(0xFF39A1FF),
          bool disableCenter = true}) =>
      disableCenter
          ? Column(
              children: [
                LoadingAnimationWidget.staggeredDotsWave(
                  color: colors,
                  size: size,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText(
                      'Working on it ',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RotateAnimatedText(
                      'Uploading the document ',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RotateAnimatedText(
                      'Uploading the document ',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RotateAnimatedText(
                      'processing the document ',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RotateAnimatedText(
                      'Extracting the text',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RotateAnimatedText(
                      'Extracting the text',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RotateAnimatedText(
                      'Extracting the text',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RotateAnimatedText(
                      'Extracting the text',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RotateAnimatedText(
                      'Extracting the text',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RotateAnimatedText(
                      'Extracting the text',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RotateAnimatedText(
                      'Extracting the text',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                )
              ],
            )
          : Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: colors,
                size: size,
              ),
            );

  static Color colorTheme = Color(0xFF39A1FF);

  static Future<void> showSubscriptionSnackbar(
      {required BuildContext context,
      required String msg,
      Color color = const Color(0xFF1ABC9C)}) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(msg),
      ),
    );
  }

  static String formatDateFromTimestamp(dynamic input) {
    try {
      DateTime dateTime;

      if (input is Timestamp) {
        // Convert Timestamp to DateTime
        dateTime = DateTime.fromMillisecondsSinceEpoch(input.seconds * 1000);
      } else if (input is DateTime) {
        // Input is already DateTime
        dateTime = input;
      } else {
        // Handle other cases
        throw Exception('Invalid input type');
      }

      // Format the DateTime
      String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);

      return formattedDate;
    } catch (e) {
      print("Error $e");
      return "Error $e";
    }
  }

  /// this function with show the timestamp as date with time ex,, 24 may 2024 15.00
  static String formatDateFromTimestampWithTime(dynamic input) {
    try {
      DateTime dateTime;

      if (input is Timestamp) {
        // Convert Timestamp to DateTime
        dateTime = DateTime.fromMillisecondsSinceEpoch(input.seconds * 1000);
      } else if (input is DateTime) {
        // Input is already DateTime
        dateTime = input;
      } else {
        // Handle other cases
        throw Exception('Invalid input type');
      }

      // Format the DateTime
      String formattedDate = DateFormat('dd MMM yyyy HH:mm').format(dateTime);

      return formattedDate;
    } catch (e) {
      print("Error $e");
      return "Error $e";
    }
  }

  /// this is to deal with events colors
  static final List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.yellow,
    Colors.indigo,
    Colors.pink,
    Colors.cyan,
  ];

  static int _currentIndex = 0;

  static Color getNextColor() {
    Color nextColor = colors[_currentIndex];
    _currentIndex = (_currentIndex + 1) % colors.length;
    return nextColor;
  }

  static String timeStamp() {
    // Create a DateFormat object for the desired output
    final DateFormat dayFormat = DateFormat('dd');
    final DateFormat monthFormat =
        DateFormat('MMM', 'en_US'); // Use short month format
    final DateFormat yearFormat = DateFormat('yyyy');
    final DateFormat hourMinuteFormat = DateFormat('HH.mm.ss.SS');

    // Format each part of the date
    String day = dayFormat.format(DateTime.now());
    String month = monthFormat
        .format(DateTime.now())
        .toLowerCase(); // Convert to lowercase
    String year = yearFormat.format(DateTime.now());
    String hourMinute = hourMinuteFormat.format(DateTime.now());

    // Combine all parts into the desired format
    return '$day.$month.$year:$hourMinute';
  }

  static bool inRomanian = true;

  static DateTime? parseDate(String dateString) {
    try {
      DateFormat format = DateFormat("dd-MM-yyyy");
      DateTime date = format.parse(dateString);
      return date;
    } catch (e) {
      print("Error parsing date: $e");
      return null;
    }
  }

  /// THis function gonna display the invoice detales
  static void showInvoicePopup(
      BuildContext context, Map<String, dynamic> invoiceData) {
    List<String> opListAfterRemoveEmptyString = List<String>.from(invoiceData["opUrl"]).where((element) => element.isNotEmpty)?.toList() ?? [""];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side - Image
                Expanded(
                  flex: 4,
                  child: invoiceData["isItPdf"]
                      ? SfPdfViewer.network(invoiceData['url'])
                      : Image.network(
                          invoiceData['url'] ?? '',
                          fit: BoxFit.contain,
                        ),
                ),
                SizedBox(width: 16.0),

                // Right side - Details
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          invoiceData['invoice_title'] ?? 'No Title',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                            'Invoice Number: ${invoiceData['invoice_number'] ?? ''}'),
                        Text(
                            'Invoice Series: ${invoiceData['invoice_series'] ?? ''}'),
                        Text(
                            'Invoice Description: ${invoiceData['invoice_description'] ?? ''}'),
                        Text('Issue Date: ${invoiceData['issue_date'] ?? ''}'),
                        Text('Due Date: ${invoiceData['due_date'] ?? ''}'),
                        Text('Added At: ${invoiceData['addedAt'] ?? ''}'),
                        Text(
                            'Debtor Name: ${invoiceData['debtor_name'] ?? ''}'),
                        Text(
                            'Creditor Name: ${invoiceData['creditor_name'] ?? ''}'),
                        Text(
                            'Creditor Bank: ${invoiceData['creditor_bank'] ?? ''}'),
                        Text(
                            'Creditor IBAN: ${invoiceData['creditor_iban'] ?? ''}'),
                        Text('Currency: ${invoiceData['currency'] ?? ''}'),
                        Text(
                            'TVA Percent: ${invoiceData['invoice_tva_percent'] ?? ''}%'),
                        Text(
                            'TVA Value: ${invoiceData['invoice_tva_value'] ?? ''}'),
                        Text(
                            'Total Value: ${invoiceData['total_value']?.toStringAsFixed(2) ?? ''} RON'),


                        /// In case the OP list lenght is 0 this mean there is no OP yet
                        (opListAfterRemoveEmptyString.isEmpty)
                            ? Text('OP\'s: No OP\'s yet.')
                            : Row(
                                children: [
                                  Text('OP\'s: '),
                                  ...opListAfterRemoveEmptyString
                                      .map(
                                        (e) => TextButton(
                                          onPressed: () {
                                            html.window.open(e, 'OP');
                                            // print("op" + opUrl);
                                          },
                                          child: Text(
                                            'OP ${opListAfterRemoveEmptyString.indexOf(e) + 1}',
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  TextButton(
                                    onPressed: () {
                                      try {
                                        for (int i = 0;
                                            i < opListAfterRemoveEmptyString.length;
                                            i++) {
                                          print(i);
                                          downloadFile2(
                                              opListAfterRemoveEmptyString[i]);
                                        }
                                      } catch (e) {
                                        print("error om OPS exporint $e");
                                      }
                                    },
                                    child: Text('Export OP\'s '),
                                  ),
                                ],
                              ),
                        SizedBox(height: 16.0),

                        // Custom Codes and Tags
                        Text(
                            'Custom Code 1: ${invoiceData['custom_code_1'] ?? ''}'),
                        Text(
                            'Custom Code 2: ${invoiceData['custom_code_2'] ?? ''}'),
                        Text(
                            'Custom Code 3: ${invoiceData['custom_code_3'] ?? ''}'),
                        Text(
                            'Custom Code 4: ${invoiceData['custom_code_4'] ?? ''}'),
                        Text(
                            'Selected Account Code Tag 4: ${invoiceData['selectedAccountCodeTag_4'] ?? ''}'),
                        Text(
                            'Selected Internal Code Tag 3: ${invoiceData['selectedInternelCodeTag_3'] ?? ''}'),
                        Text(
                            'Selected Label Tag 2: ${invoiceData['selectedLabelTag_2'] ?? ''}'),
                        Text(
                            'Selected Sub Tag 1: ${invoiceData['selectedSubTag_1'] ?? ''}'),
                        SizedBox(height: 16.0),

                        // Additional Description
                        Text(
                          'Additional Description:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(invoiceData['additional_description'] ?? ''),
                        SizedBox(height: 16.0),

                        // Dynamic Items List
                        Text(
                          'Items:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ...List<Map<String, dynamic>>.from(
                                invoiceData['items'] ?? [])
                            .map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${item['item_name']} x${item['item_quantity']}'),
                                Text(
                                    '${item['item_unit_price'].toString()/*.toStringAsFixed(2)*/} ${item['item_unit_currency']}'),
                              ],
                            ),
                          );
                        }).toList(),

                        // Operational URL
                        if (invoiceData['opUrl'] != null &&
                            invoiceData['opUrl'].isNotEmpty)
                          SizedBox(height: 16.0),
                        if (invoiceData['opUrl'] != null &&
                            invoiceData['opUrl'].isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              // Handle URL launch
                            },
                            child: Text(
                              'More Info',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Implement export logic here, e.g., export as PDF or CSV
                //downloadFile(  invoiceData['url'] ?? '');
                downloadFile2(invoiceData['url'] ?? '');
              },
              child: Text('Export'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  static void showOPsPopup(
      {required BuildContext context,
      required Map<String, dynamic> transactionData ,
      required Function fetchAllOpAgain
      }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side - Image or PDF Viewer
                Expanded(
                  flex: 4,
                  child: transactionData["isItPdf"]
                      ? SfPdfViewer.network(transactionData['url'])
                      : Image.network(
                          transactionData['url'] ?? '',
                          fit: BoxFit.contain,
                        ),
                ),
                SizedBox(width: 16.0),

                // Right side - Details
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transaction Reference: ${transactionData['transaction_reference'] ?? 'No Reference'}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text('OP ID: ${transactionData['op_id'] ?? ''}'),
                        Text('Invoice number: ${transactionData['invoice_number'] ?? ''}'),
                        Text('Invoice issued date: ${transactionData['invoice_issued_date'] ?? ''}'),
                        Text(
                            'Transaction Amount: ${transactionData['transaction_amount']?.toStringAsFixed(2) ?? ''} ${transactionData['currency'] ?? ''}'),
                        Text(
                            'Transaction Date: ${transactionData['transaction_date'] ?? ''}'),
                        Text(
                            'Transaction Description: ${transactionData['transaction_description'] ?? ''}'),
                        Text('Added At: ${staticVar.formatDateFromTimestampWithTime(transactionData['addedAt']) ?? ''}'),
                        Text(
                            'Debtor Name: ${transactionData['debtor_name'] ?? ''}'),
                        Text(
                            'Debtor Bank: ${transactionData['debtor_bank_name'] ?? ''}'),
                        Text(
                            'Debtor IBAN: ${transactionData['debtor_iban'] ?? ''}'),
                        Text(
                            'Creditor Name: ${transactionData['creditor_name'] ?? ''}'),
                        Text(
                            'Creditor Bank: ${transactionData['creditor_bank_name'] ?? ''}'),
                        Text(
                            'Creditor IBAN: ${transactionData['creditor_iban'] ?? ''}'),
                        SizedBox(height: 16.0),

                        // Custom Codes and Tags
                        Text(
                            'Custom Code 1: ${transactionData['selectedAccountCodeTag_4'] ?? ''}'),
                        Text(
                            'Custom Code 2: ${transactionData['selectedInternelCodeTag_3'] ?? ''}'),
                        Text(
                            'Custom Code 3: ${transactionData['selectedLabelTag_2'] ?? ''}'),
                        Text(
                            'Custom Code 4: ${transactionData['selectedSubTag_1'] ?? ''}'),
                        SizedBox(height: 16.0),

                        // Additional Description
                        Text(
                          'OP Description:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(transactionData['op_description'] ?? ''),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            transactionData["invoiceDetails"]?["InvoiceUrl"] == "" ?
            Text(""):
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green, // Set the text color to red
              ),
              onPressed: () {
                html.window.open(transactionData["invoiceDetails"]?["InvoiceUrl"] , 'new tab');

              },
              child: Text('Show invoice'),
            ),

            TextButton(
              onPressed: () {
                // Implement export logic here, e.g., export as PDF or CSV
                downloadFile2(transactionData['url'] ?? '');
              },
              child: Text('Export'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  /// THis functions gonna export the data into files
  static void downloadFile(String url) {
    html.AnchorElement anchorElement = new html.AnchorElement(href: url)
      ..setAttribute("download", "")
      ..click();
    //
    // html.AnchorElement anchorElement =  new html.AnchorElement(href: url);
    // anchorElement.download = url;
    // anchorElement.click();
  }

  static void downloadFile2(String url) async {
    try {
      // Fetch the file content
      final response =
          await html.HttpRequest.request(url, responseType: 'blob');
      final blob = response.response as html.Blob;

      // Create an object URL from the Blob
      final objectUrl = html.Url.createObjectUrlFromBlob(blob);

      // Create a hidden anchor element
      final anchorElement = html.AnchorElement(href: objectUrl)
        ..setAttribute("download", "")
        ..style.display = 'none';

      // Add the anchor to the DOM
      html.document.body?.append(anchorElement);

      // Trigger the download
      anchorElement.click();

      // Clean up by removing the anchor and revoking the object URL
      anchorElement.remove();
      html.Url.revokeObjectUrl(objectUrl);
    } catch (e) {}
  }

  static String urlAPI = "https://5bb9-81-196-26-12.ngrok-free.app/";


}
