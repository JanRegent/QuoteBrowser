import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class SidebarPage extends StatefulWidget {
  const SidebarPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              // showTooltip: false,
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.blue[100],
              selectedHoverColor: Colors.blue[100],
              selectedColor: Colors.lightBlue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.blueGrey[700]
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Text(
                    'mohada',
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),
                ),
              ),
            ),
            items: [
              SideMenuItem(
                title: 'Dashboard',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.home),
                badgeContent: const Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Users',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                title: 'Files',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.file_copy_rounded),
                trailing: Container(
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 3),
                      child: Text(
                        'New',
                        style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                      ),
                    )),
              ),
              SideMenuItem(
                title: 'Download',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.download),
              ),
              SideMenuItem(
                builder: (context, displayMode) {
                  return const Divider(
                    endIndent: 8,
                    indent: 8,
                  );
                },
              ),
              SideMenuItem(
                title: 'Settings',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.settings),
              ),
              // SideMenuItem(
              //   onTap:(index, _){
              //     sideMenu.changePage(index);
              //   },
              //   icon: const Icon(Icons.image_rounded),
              // ),
              // SideMenuItem(
              //   title: 'Only Title',
              //   onTap:(index, _){
              //     sideMenu.changePage(index);
              //   },
              // ),
              const SideMenuItem(
                title: 'Exit',
                icon: Icon(Icons.exit_to_app),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Dashboard',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Users',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Files',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Download',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Only Title',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Only Icon',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
