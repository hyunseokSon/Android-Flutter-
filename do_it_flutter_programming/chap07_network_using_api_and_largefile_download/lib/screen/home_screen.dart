import 'package:chap07_network_using_kakao_api/screen/network_screen.dart';
import 'package:flutter/material.dart';

import 'input_image_url.dart';
import 'large_file_download.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3,
        vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          NetworkScreen(),
          LargeFileDownload(),
          InputImageUrlDownload(),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: [
          Tab(
            icon: Icon(
              Icons.network_cell,
              color: Colors.blue,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.image,
              color: Colors.blue,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.add_a_photo,
              color: Colors.blue,
            )
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
}
