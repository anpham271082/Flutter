import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/core/common/styles/styles.dart';
import 'package:my_app_flutter/core/constants/colors.dart';
import 'package:my_app_flutter/core/utils/devices.dart';
import 'package:my_app_flutter/core/utils/dialogs.dart';
import 'package:my_app_flutter/core/utils/files.dart';
import 'package:my_app_flutter/features/base_page.dart';
import 'package:my_app_flutter/features/login/view/pages/authentication_login.dart';

class LoginPage extends BasePage {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage> {
  AuthenticationLogin authenticationLogin = AuthenticationLogin();
  final TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    emailFocusNode.addListener(() {
      setState(() {});
    });
    passwordFocusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void requestEmailFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(emailFocusNode);
    });
  }

  void requestPasswordFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(passwordFocusNode);
    });
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    authenticationLogin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.colorTextInput),
              onPressed: () => Navigator.of(context).pop(),
            ),
          )),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  AppFiles.shared.language("login!", "login!"),
                  style: TextStyle(
                      fontSize: 20 * AppDevices.shared.ratio,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorTextInput),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: StreamBuilder(
                      stream: authenticationLogin.emailStream,
                      builder: (context, snapshot) => AppStyles.textFormField(
                          emailController,
                          emailFocusNode,
                          AppFiles.shared.language("email", "email"),
                          requestEmailFocus,
                          Image.asset("assets/icons/ic_mail.png"),
                          snapshot))),
              StreamBuilder(
                  stream: authenticationLogin.passStream,
                  builder: (context, snapshot) => AppStyles.textFormField(
                      passwordController,
                      passwordFocusNode,
                      AppFiles.shared.language("password", "password"),
                      requestPasswordFocus,
                      Image.asset("assets/icons/ic_phone.png"),
                      snapshot,
                      obscureText: true)),
              Container(
                constraints:
                    BoxConstraints.loose(const Size(double.infinity, 40)),
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    AppFiles.shared
                        .language("forgot password ?", "forgot password ?"),
                    style: TextStyle(
                        fontSize: 13 * AppDevices.shared.ratio,
                        color: Colors.blue),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      doneClick();
                    },
                    child: Text(
                      AppFiles.shared.language("done", "done"),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13 * AppDevices.shared.ratio),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: RichText(
                  text: TextSpan(
                      text: AppFiles.shared.language(
                          "don't have an account ?", "has account yet ?"),
                      style: TextStyle(
                          color: AppColors.colorTextInput,
                          fontSize: 13 * AppDevices.shared.ratio),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                               /* debugPrint(ModalRoute.of(AppNavigator
                                        .navigationKey.currentContext!)!
                                    .settings
                                    .name);
                                //main.myAppStateKey.currentState!.printSample();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage()));*/
                              },
                            text: AppFiles.shared
                                .language("register now!", "register now!"),
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 13 * AppDevices.shared.ratio))
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void doneClick() {
    var isValid = authenticationLogin.isValidLogin(
        emailController.text, passwordController.text);
    if (isValid) {
      AppDialogs.shared.showLoading(context);
      authenticationLogin.signIn(emailController.text, passwordController.text,
          () {
        AppDialogs.shared.hideLoading();
        Navigator.of(context).pop();
      }, (msg) {
        AppDialogs.shared.hideLoading();
      });
    }
  }
}
