import 'package:brik/common/helpers/enum.dart';
import 'package:brik/features/auth/presentation/pages/register.dart';
import 'package:brik/features/auth/presentation/provider/login_notifier.dart';
import 'package:brik/features/dashboard/presentation/pages/dashboard.dart';
import 'package:brik/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();

  late LoginNotifier loginNotifier;

  Future<void> login() async {
    if(formKey.currentState!.validate()) {
      await loginNotifier.login();

      if(loginNotifier.state == ProviderState.error) {
        ShowSnackbar.snackbarErr(loginNotifier.message);
        return;
      } else {
        if(mounted) {
          Navigator.pushReplacementNamed(context, DashboardPage.route);
        }
      }
       
    }
  }

  @override 
  void initState() {
    super.initState();

    loginNotifier = context.read<LoginNotifier>();

    loginNotifier.emailC = TextEditingController();
    loginNotifier.passC = TextEditingController();
  }

  @override
  void dispose() {
    loginNotifier.emailC.dispose();
    loginNotifier.passC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text("Login",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        )
      ),
      body: RefreshIndicator.adaptive(
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
                          controller: loginNotifier.emailC,
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
                          controller: loginNotifier.passC,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password cannot be empty';
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Password",
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

                      ],
                    )
                  ),

                  const SizedBox(height: 25.0),

                  Consumer<LoginNotifier>(
                    builder: (_, notifier, __) {
                      return ElevatedButton(
                        onPressed: login,
                        child: notifier.state == ProviderState.loading 
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Login',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        )
                      );
                    },
                  ),     
                  
                  const SizedBox(height: 15.0),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
      
                    const Text("Don't have an account ?",
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
      
                    const SizedBox(height: 10),
      
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.route);
                      },
                      child: const Text("Register",
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
            )

          ],
        )
      )
    );
  }
}