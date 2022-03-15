import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/view_tag.dart';

class EmailHelper {
  Future sendFoundTagMail(ViewTag tag) async {
    log('email');
    String tagName = tag.tagName;
    String email = tag.email;
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': 'service_mgrlbjd',
        'user_id': 'qUyZajkSQ201_Ofmb',
        'template_id': 'template_skz1ppz',
        'accessToken': '_FTJWp03DjhKgRTYQVGks',
        'template_params': {
          'owner_email': email,
          'tag_name': tagName,
        }
      }),
    );
    log('Email sending response: ' + response.body);
  }
}
