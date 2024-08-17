// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Hàm gửi email
  Future<void> sendEmail(
      String subject, String body, String recipientEmail) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [recipientEmail],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Cảm ơn bạn!'),
          content: const Text('Ý kiến của bạn đã được gửi đi.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        ),
      );
      _subjectController.clear();
      _messageController.clear();
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Lỗi'),
          content:
              const Text('Gửi email không thành công. Vui lòng thử lại sau.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Liên hệ và góp ý",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: theme.primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Text(
                'Chúng tôi rất vui được nhận góp ý từ bạn!',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'Hãy để lại thông tin liên hệ và ý kiến của bạn dưới đây:',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Nhập tiêu đề email...',
                  labelText: 'Tiêu đề',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tiêu đề';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _messageController,
                maxLines: 8,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Nhập ý kiến của bạn...',
                  labelText: 'Ý kiến của bạn',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập ý kiến của bạn';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    final String subject = _subjectController.text;
                    final String message = _messageController.text;
                    const String recipientEmail =
                        'hoangvietdoican2004@gmail.com'; // Địa chỉ email nhận
                    sendEmail(subject, message, recipientEmail);
                  }
                },
                child: const Text('Gửi ý kiến'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
