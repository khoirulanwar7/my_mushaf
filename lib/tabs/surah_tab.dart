import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:holyquran_app/globals.dart';
import 'package:holyquran_app/models/surah.dart';
import 'package:holyquran_app/screens/detail_screen.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  Future<List<Surah>> _getSurahList() async {
    String data = await rootBundle.loadString("assets/data/list_surah.json");
    return surahFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
        future: _getSurahList(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return ListView.separated(
              itemBuilder: (context, index) => _surahItem(
                  context: context, surah: snapshot.data!.elementAt(index)),
              separatorBuilder: (context, index) => Container(),
              itemCount: snapshot.data!.length);
        }));
  }

  // Widget _surahItem({required Surah surah}) => Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 16),
  //       child: Row(
  //         children: [
  //           Text(
  //             surah.namaLatin,
  //             style: GoogleFonts.poppins(
  //                 color: primary, fontWeight: FontWeight.w600),
  //           ),
  //           Text(
  //             surah.nama,
  //             style: GoogleFonts.poppins(color: text),
  //           ),
  //         ],
  //       ),
  //     );

  Widget _surahItem({required Surah surah, required BuildContext context}) =>
      InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailScreen(
                  noSurat: surah.nomor,
                ))),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Stack(
                  children: [
                    SvgPicture.asset('assets/svgs/ic_nosurah.svg'),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Center(
                          child: Text(
                        "${surah.nomor}",
                        style: GoogleFonts.poppins(
                            color: primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )),
                    )
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surah.namaLatin,
                      style: GoogleFonts.poppins(
                          color: primary, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(surah.tempatTurun.name,
                            style: GoogleFonts.poppins(
                              color: text,
                              fontSize: 12,
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('-'),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${surah.jumlahAyat} Ayat",
                          style: GoogleFonts.poppins(
                              color: text,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ],
                    )
                  ],
                )),
                Text(surah.nama,
                    style: GoogleFonts.amiri(
                        color: primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600))

                // const Text(
                //   surah.namaLatin,
                //   style: GoogleFonts.poppins(
                //       color: primary, fontWeight: FontWeight.w600),
                // ),
                // Text(
                //   surah.nama,
                //   style: GoogleFonts.poppins(color: text),
                // ),
              ],
            ),
          ),
        ),
      );
}
