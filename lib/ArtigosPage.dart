import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:webcicle/HomePage.dart';
import 'package:webcicle/theme/colors.dart';

class ArtigosPage extends StatefulWidget {
  const ArtigosPage({Key? key}) : super(key: key);

  @override
  _ArtigosPageState createState() => _ArtigosPageState();
}

class _ArtigosPageState extends State<ArtigosPage> {
  final FirebaseFirestore fb = FirebaseFirestore.instance;
  bool isLoading = false;
  bool isRetrieved = false;
  QuerySnapshot<Map<String, dynamic>>? cachedResult;
  TextEditingController tituloController = TextEditingController();
  TextEditingController textoController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(builder: (context, constraint) {
        var largura = constraint.maxWidth;
        var altura = constraint.maxHeight;
        final _formKey = GlobalKey<FormState>();
        return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: !isRetrieved
                  ? FutureBuilder(
                      future: getImages(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          isRetrieved = true;
                          cachedResult = snapshot.data;
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot ds =
                                    snapshot.data!.docs[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 6.h),
                                  child: Card(
                                    borderOnForeground: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 1,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: InkWell(
                                        child: Column(
                                          children: [
                                            Image.network(
                                              snapshot.data!.docs[index]
                                                  .data()["url"],
                                              fit: BoxFit.cover,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3.h,
                                                  horizontal: 3.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        .data()["name"],
                                                    style: GoogleFonts.inter(
                                                      fontSize: 9.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors.gray,
                                                    ),
                                                    maxLines: 5,
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 8.sp,
                                                    ),
                                                    onPressed: () {
                                                      FirebaseFirestore.instance
                                                          .collection('cards')
                                                          .doc(ds.id)
                                                          .delete();
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      HomePage(
                                                                        uid: '',
                                                                      )));
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          showGeneralDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              barrierLabel:
                                                  MaterialLocalizations.of(
                                                          context)
                                                      .modalBarrierDismissLabel,
                                              barrierColor: Colors.black45,
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 200),
                                              pageBuilder:
                                                  (BuildContext buildContext,
                                                      Animation animation,
                                                      Animation
                                                          secondaryAnimation) {
                                                return Scaffold(
                                                  body: CustomScrollView(
                                                    slivers: [
                                                      SliverAppBar(
                                                        pinned: true,
                                                        backgroundColor:
                                                            AppColors.green,
                                                        expandedHeight: 30.h,
                                                        flexibleSpace:
                                                            FlexibleSpaceBar(
                                                          background:
                                                              Image.network(
                                                            snapshot.data!
                                                                .docs[index]
                                                                .data()["url"],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      SliverFillRemaining(
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 0.h,
                                                                  horizontal:
                                                                      5.h),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                  height: 5.h),
                                                              Text(
                                                                snapshot.data!
                                                                    .docs[index]
                                                                    .data()["name"],
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontSize:
                                                                      9.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      AppColors
                                                                          .gray,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 3.h),
                                                              Text(
                                                                snapshot.data!
                                                                        .docs[index]
                                                                        .data()[
                                                                    "texto"],
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontSize:
                                                                      9.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color:
                                                                      AppColors
                                                                          .gray,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        }),
                                  ),
                                );
                              });
                        } else if (snapshot.connectionState ==
                            ConnectionState.none) {
                          return Text("No data");
                        }
                        return CircularProgressIndicator();
                      },
                    )
                  : displayCachedList(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: MaterialLocalizations.of(context)
                        .modalBarrierDismissLabel,
                    barrierColor: Colors.black45,
                    transitionDuration: const Duration(milliseconds: 200),
                    pageBuilder: (BuildContext buildContext,
                        Animation animation, Animation secondaryAnimation) {
                      return Sizer(builder: (context, orientation, deviceType) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text('Adicionar Artigo'),
                            backgroundColor: AppColors.green,
                            elevation: 0,
                            centerTitle: true,
                          ),
                          body: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 10.h),
                            child: Container(
                                width: largura,
                                height: altura,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Cadastro de Artigo',
                                        style: GoogleFonts.inter(
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        'Preencha corretamente todos os campos do formulário para cadastrar um artigo',
                                        style: GoogleFonts.inter(
                                          fontSize: 8.sp,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      TextFormField(
                                        controller: tituloController,
                                        decoration: InputDecoration(
                                          labelText: "Título",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Digite um título';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      TextFormField(
                                        controller: textoController,
                                        decoration: InputDecoration(
                                          labelText: "Texto",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Digite um texto';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      TextFormField(
                                        controller: urlController,
                                        decoration: InputDecoration(
                                          labelText: "Url da imagem",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Cole o url da imagem';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      SizedBox(
                                        width: 50.w,
                                        height: 5.h,
                                        child: ElevatedButton(
                                          child: Text(
                                            'Cadastrar Artigo',
                                            style: GoogleFonts.inter(
                                                fontSize: 8.sp),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: AppColors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      15), // <-- Radius
                                            ),
                                          ),
                                          onPressed: () {
                                            fb.collection("cards").add({
                                              "name": tituloController.text,
                                              "texto": textoController.text,
                                              "url": urlController.text,
                                            }).then((value) {
                                              print(value.id);
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage(uid: '')),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      });
                    });
              },
              child: Icon(Icons.add),
              backgroundColor: AppColors.green,
            ));
      });
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getImages() {
    return fb.collection("cards").get();
  }

  ListView displayCachedList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: cachedResult!.docs.length,
        itemBuilder: (BuildContext context, int index) {
          print(cachedResult!.docs[index].data()["url"]);
          return ListTile(
            contentPadding: EdgeInsets.all(8.0),
            title: Text(
              cachedResult!.docs[index].data()["name"],
            ),
            leading: Image.network(cachedResult!.docs[index].data()["url"],
                fit: BoxFit.fill),
          );
        });
  }
}
