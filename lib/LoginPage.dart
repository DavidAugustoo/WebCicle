import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:webcicle/HomePage.dart';
import 'package:webcicle/theme/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: LayoutBuilder(builder: (context, contraint) {
          var largura = contraint.maxWidth;
          var altura = contraint.maxHeight;

          if (largura < 960) {
            return Container(
                width: largura,
                height: altura,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.h),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Bem vindo!',
                              style: GoogleFonts.inter(
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              'Por favor, entre com suas crendenciais de funcionário',
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Digite seu email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Senha",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Digite seu senha';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: isLoading
                                  ? CircularProgressIndicator()
                                  : Container(
                                      width: largura / 3,
                                      height: 7.h,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(AppColors.green)),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            logInToFb();
                                          }
                                        },
                                        child: Text(
                                          'Entrar',
                                          style: GoogleFonts.inter(
                                              fontSize: 10.sp),
                                        ),
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          } else {
            return Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      width: largura,
                      height: altura,
                      color: Color(0xff1FCC79),
                      child: Center(
                        child: Image.asset(
                          './assets/logo.png',
                          width: 10.h,
                        ),
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Container(
                        width: largura,
                        height: altura,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 10.h),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Bem vindo!',
                                  style: GoogleFonts.inter(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  'Por favor, entre com suas credenciais de funcionário',
                                  style: GoogleFonts.inter(
                                    fontSize: 5.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Digite seu email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "Senha",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Digite seu senha';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: isLoading
                                      ? CircularProgressIndicator()
                                      : Container(
                                          width: largura / 4,
                                          height: altura / 20,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        AppColors.green)),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                logInToFb();
                                              }
                                            },
                                            child: Text(
                                              'Entrar',
                                              style: GoogleFonts.inter(
                                                  fontSize: 6.sp),
                                            ),
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                        ))),
              ],
            );
          }
        }),
      );
    });
  }

  void logInToFb() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      isLoading = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(uid: result.user!.uid)),
      );
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      isLoading = false;
                    });
                  },
                )
              ],
            );
          });
    });
  }
}
