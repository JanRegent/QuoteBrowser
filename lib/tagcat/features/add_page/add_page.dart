import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/app_const.dart';
import '../../constants/route_names.dart';
import '../../features/detail_page/detail_page.dart';
import '../../features/home_page/contact_list_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../entities/contact.dart';

class AddPage extends ConsumerStatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddPage> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<AddPage> {
  late Contact? _contactData;

  @override
  void initState() {
    super.initState();
    _contactData = ref.read(selectedContactProvider);
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
        child: FormBuilder(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FormField(
                labelString: 'Name',
                initialValue: _contactData?.name ?? '',
              ),
              FormField(
                labelString: 'Surename',
                initialValue: _contactData?.surename ?? '',
              ),
              FormField(
                labelString: 'Email',
                initialValue: _contactData?.email ?? '',
                inputType: TextInputType.emailAddress,
              ),
              const Spacer(),
              EditButton(
                text: 'SAVE',
                onPressed: () {
                  formKey.currentState?.save();
                  Contact contact = Contact(
                      id: 0,
                      name: formKey.currentState!.value['Name'] ?? '',
                      surename:
                          formKey.currentState?.value['Surename'].toString() ??
                              '',
                      email: formKey.currentState?.value['Email'].toString() ??
                          '');
                  if (contact.name.isEmpty &&
                      contact.surename.isEmpty &&
                      contact.email.isEmpty) {
                    return;
                  } else if (_contactData == null) {
                    ref
                        .read(contactListControllerProvider.notifier)
                        .saveContact(contact: contact);
                    debugPrint('save : $contact');
                  } else {
                    contact.id = _contactData!.id;
                    ref
                        .read(contactListControllerProvider.notifier)
                        .updateContact(contact: contact);
                    debugPrint('update : $contact');
                  }
                  Navigator.pushNamedAndRemoveUntil(context,
                      RouteNames.homePage, (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormField extends StatelessWidget {
  const FormField(
      {Key? key,
      required this.labelString,
      required this.initialValue,
      this.inputType})
      : super(key: key);

  final String labelString;
  final String initialValue;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: FormBuilderTextField(
        name: labelString,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelString,
            labelStyle: AppConst.textStyleGeneral),
        initialValue: initialValue,
        keyboardType: inputType ?? TextInputType.name,
      ),
    );
  }
}
