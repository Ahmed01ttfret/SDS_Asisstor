import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:typed_data';

Future<String> extractTextFromBytes(Uint8List bytes) async {

  final PdfDocument document = PdfDocument(inputBytes: bytes);


  final PdfTextExtractor extractor = PdfTextExtractor(document);


  final String text = extractor.extractText();


  document.dispose();

  return text;
}