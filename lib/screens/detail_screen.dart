import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:holyquran_app/globals.dart';
import 'package:holyquran_app/models/surah.dart';
import 'package:holyquran_app/screens/home_screen.dart';

import '../models/ayat.dart';

class DetailScreen extends StatelessWidget {
  final int noSurat;
  const DetailScreen({super.key, required this.noSurat});

  Future _getDetailSurah() async {
    var data = await Dio().get('https://equran.id/api/surat/$noSurat');
    return Surah.fromJson(json.decode(data.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getDetailSurah(),
      initialData: null,
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: background,
          );
        }
        Surah surah = snapshot.data!;
        return Scaffold(
          backgroundColor: background,
          appBar: _appBar(context: context, surah: surah),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: _details(surah: surah),
              )
            ],
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.separated(
                itemBuilder: (context, index) => _ayatItem(
                    ayat:
                        surah.ayat!.elementAt(index + (noSurat == 1 ? 1 : 0))),
                itemCount: surah.jumlahAyat + (noSurat == 1 ? -1 : 0),
                separatorBuilder: (context, index) => Container(),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _ayatItem({required Ayat ayat}) => Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                Container(
                  width: 27,
                  height: 27,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(27 / 2)),
                  child: Center(
                      child: Text(
                    '${ayat.nomor}',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  )),
                ),
                const Spacer(),
                const Icon(
                  Icons.share_outlined,
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 16,
                ),
                const Icon(
                  Icons.play_arrow_outlined,
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 16,
                ),
                const Icon(
                  Icons.bookmark_outline,
                  color: Colors.green,
                ),
              ]),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              ayat.ar,
              style: GoogleFonts.amiri(
                  color: Colors.green[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              ayat.idn,
              style:
                  GoogleFonts.poppins(color: Colors.green[900], fontSize: 14),
            )
          ],
        ),
      );

  Widget _details({required Surah surah}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Stack(children: [
            Container(
              height: 170,
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
                right: 20,
                child: Opacity(
                    opacity: .2,
                    child: Image.asset(
                      'assets/images/quran.png',
                      scale: 0.9,
                    ))),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/ic_nosurah.svg',
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 36,
                            width: 36,
                            child: Center(
                                child: Text(
                              "${surah.nomor}",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            )),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    surah.namaLatin,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  Text(
                    surah.arti,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        surah.tempatTurun.name,
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      Text(
                        '-',
                        style: GoogleFonts.poppins(
                            color: Colors.white, letterSpacing: 12),
                      ),
                      Text(
                        '${surah.jumlahAyat} Ayat',
                        style: GoogleFonts.poppins(color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ),
          ]),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: SvgPicture.asset(
                'assets/svgs/basmallah.svg',
                color: primary,
              ))
        ],
      ));

  AppBar _appBar({required BuildContext context, required Surah surah}) {
    return AppBar(
      backgroundColor: background,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: SvgPicture.asset('assets/svgs/ic_back.svg')),
          Text(
            surah.namaLatin,
            style: GoogleFonts.poppins(
                color: primary, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/svgs/ic_dot.svg')),
        ],
      ),
    );
  }
}
