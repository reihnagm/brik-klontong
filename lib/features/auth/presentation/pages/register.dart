import 'package:brik/features/auth/presentation/provider/register_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  static const String route = '/register';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {

  final formKey = GlobalKey<FormState>();

  late RegisterNotifier registerNotifier;

  bool obscure = false;

  Future<void> register() async {
    if(formKey.currentState!.validate()) {
      await context.read<RegisterNotifier>().register();
    } 
  }

  @override 
  void initState() {
    super.initState();

    registerNotifier = context.read<RegisterNotifier>();  

    registerNotifier.fullnameC = TextEditingController();
    registerNotifier.emailC = TextEditingController();
    registerNotifier.passwordC = TextEditingController();
  }

  @override 
  void dispose() {
    registerNotifier.fullnameC.dispose();
    registerNotifier.emailC.dispose();
    registerNotifier.passwordC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text("Register",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: CupertinoNavigationBarBackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: RefreshIndicator.adaptive(
        color: Colors.black,
        onRefresh: () {
          return Future.sync(() {

          });
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [

            SliverPadding(
              padding: const EdgeInsets.only(
                top: 100.0,
                bottom: 15.0,
                left: 25.0,
                right: 25.0
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([

                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        TextFormField(
                          controller: registerNotifier.fullnameC,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'fullname cannot be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Fullname",
                            labelStyle: TextStyle(
                              fontSize: 12.0
                            ),
                            
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black
                              )
                            )
                          ),
                        ),

                        const SizedBox(height: 20.0),

                        TextFormField(
                          controller: registerNotifier.emailC,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'e-mail cannot be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "E-mail",
                            labelStyle: TextStyle(
                              fontSize: 12.0
                            ),
                            
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black
                              )
                            )
                          ),
                        ),

                        const SizedBox(height: 20.0),

                        TextFormField(
                          controller: registerNotifier.passwordC,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password cannot be empty';
                            }
                            return null;
                          },
                          obscureText: obscure,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              child: obscure 
                              ? const Icon(Icons.visibility_off) 
                              : const Icon(Icons.visibility)
                            ),
                            labelText: "Password",
                            labelStyle: const TextStyle(
                              fontSize: 12.0
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black
                              )
                            )
                          ),
                        ),

                      ],
                    )
                  ),

                  const SizedBox(height: 25.0),

                  ElevatedButton(
                    onPressed: register,
                    child: const Text('Register',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    )
                  ),

                  const SizedBox(height: 15.0),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const Text("Already have an account ?",
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),

                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Login",
                          style: TextStyle(
                            fontSize: 12.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )

                    ],
                  )

                ])
              ),
            ),
        
          ],
        ),
      )
    );
  }
  
}