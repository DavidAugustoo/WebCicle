import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

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

          if (largura < 600) {
            return Text('Celular pequeno');
          } else if (largura < 960) {
            return Text('Celular Grande');
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
}
