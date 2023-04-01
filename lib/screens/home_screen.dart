import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:holyquran_app/globals.dart';
import 'package:holyquran_app/tabs/doa_tab.dart';
import 'package:holyquran_app/tabs/surah_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        appBar: _appBar(),
        body: DefaultTabController(
          length: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverToBoxAdapter(
                        child: _greeting(),
                      ),
                      SliverAppBar(
                        pinned: true,
                        elevation: 0,
                        backgroundColor: background,
                        automaticallyImplyLeading: false,
                        shape: Border(
                            bottom: BorderSide(
                                width: 3,
                                color:
                                    const Color(0xffaaaaaa).withOpacity(.1))),
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(0),
                          child: _tab(),
                        ),
                      )
                    ],
                body: const TabBarView(
                  children: [SurahTab(), DoaTab()],
                )),
          ),
        ));
  }

  TabBar _tab() {
    return TabBar(
        unselectedLabelColor: text,
        labelColor: primary,
        indicatorColor: primary,
        tabs: [
          _tabItem(label: "Surat"),
          _tabItem(label: "Doa Harian"),
        ]);
  }

  Tab _tabItem({required String label}) {
    return Tab(
      child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Column _greeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          'Assalamualaikum',
          style: GoogleFonts.poppins(
            color: text,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Muhammad Khoirul Anwarudin',
          style: GoogleFonts.poppins(
              color: primary, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 24,
        ),
        _lastRead()
      ],
    );
  }

  Stack _lastRead() {
    return Stack(
      children: [
        Container(
          height: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF27A145),
                    Color(0xFF26A168),
                    Color(0xFF169C78)
                  ])),
        ),
        Positioned(
            bottom: 0,
            right: 16,
            child: Image.asset(
              'assets/images/quran.png',
              scale: 1.1,
            )),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.network('https://www.minhajulatsar.com/wp-content/uploads/2021/08/ashkan-forouzani-7blIFp0kFP4-unsplash-scaled.jpg'),
                  const SizedBox(
                    width: 8,
                  ),
                  Text("Last Read",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Al-Fatihah',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Ayat No: 1',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: background,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/svgs/ic_menu.svg')),
          Text(
            'My App Mushaf',
            style: GoogleFonts.poppins(
                color: primary, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 24,
          )
        ],
      ),
    );
  }
}
