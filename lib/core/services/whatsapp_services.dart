import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

Future<void> whatsappLauncher(String phoneNumber) async {
  final sanitizedNumber = sanitizePhoneNumber(phoneNumber);

  final Uri androidUri = Uri.parse(
    "whatsapp://send?phone=$sanitizedNumber&text=${Uri.encodeComponent('Hi, thank you for your enquiry. How can we assist you further?')}",
  );

  final Uri iosUri = Uri.parse(
    "https://wa.me/$sanitizedNumber?text=${Uri.encodeComponent('Hi, thank you for your enquiry. How can we assist you further?')}",
  );

  try {
    if (Platform.isIOS) {
      if (await canLaunchUrl(iosUri)) {
        await launchUrl(iosUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch WhatsApp';
      }
    } else {
      if (await canLaunchUrl(androidUri)) {
        await launchUrl(androidUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch WhatsApp';
      }
    }
  } catch (e) {
    print("WhatsApp is not installed: $e");
    // EasyLoading.showError('WhatsApp is not installed.');
  }
}

String sanitizePhoneNumber(String phoneNumber) {
  return phoneNumber.replaceAll('+', '');
}
