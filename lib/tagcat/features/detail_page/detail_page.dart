import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/app_const.dart';
import '../../constants/route_names.dart';

import '../../entities/contact.dart';
import '../home_page/contact_list_controller.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Contact? contactData = ref.read(selectedContactProvider);
    return Container(
      color: AppConst.kGray,
      child: Center(
        child: Hero(
          tag: 'ListViewHero',
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 46,
                      backgroundColor: AppConst.kRedTitle,
                      child: Text(
                        '${contactData?.name.substring(0, 1)}${contactData?.surename.substring(0, 1)}',
                        style:
                            const TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                    Text(
                      '${contactData?.name} ${contactData?.surename}',
                      style: AppConst.textStyleTitle.copyWith(fontSize: 48),
                    ),
                    Text(
                      contactData?.email ?? '',
                      style: AppConst.textStyleGeneral.copyWith(fontSize: 22),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          EditButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RouteNames.addPage);
                            },
                            text: 'EDIT',
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          EditButton(
                            onPressed: () {
                              ref
                                  .read(contactListControllerProvider.notifier)
                                  .deleteContact(contact: contactData!);
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RouteNames.homePage,
                                  (Route<dynamic> route) => false);
                            },
                            text: 'DELETE',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppConst.kGray),
        shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
