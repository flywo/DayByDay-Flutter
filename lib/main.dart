import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/pages/home/splash_page.dart';
import 'package:todo_list/utils/theme_util.dart';

import 'i10n/localization_intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(
    ProviderConfig.getInstance().getGlobal(MyApp()),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLoading = true;
  var futureBuilder;

  @override
  void initState() {
    super.initState();
    futureBuilder = getWebURL();
  }

  Future<String> getWebURL() async {
    MethodChannel channel = MethodChannel("FlutterCall");
    var result = await channel.invokeMethod('getAppType');
    print(result);
    if (result != "other") {
      result = await channel.invokeMethod('getWebURL');
      print(result);
      return result;
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context)..setContext(context);

    return MaterialApp(
      title: model.appName,
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DemoLocalizationsDelegate()
      ],
      supportedLocales: [
        const Locale('en', 'US'), // 美国英语
        const Locale('zh', 'CN'), // 中文简体
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        debugPrint("locale:$locale   sups:$supportedLocales  currentLocale:${model.currentLocale}");
        if (model.currentLocale == locale) return model.currentLocale;
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale == locale) {
            model.currentLocale = locale;
            model.currentLanguageCode = [
              locale.languageCode,
              locale.countryCode
            ];
            locale.countryCode == "CN"
                ? model.currentLanguage = "中文"
                : model.currentLanguage = "English";
            return model.currentLocale;
          }
        }
        if (model.currentLocale == null) {
          model.currentLocale = Locale('zh', "CN");
          return model.currentLocale;
        }
        return model.currentLocale;
      },
      localeListResolutionCallback:
          (List<Locale> locales, Iterable<Locale> supportedLocales) {
        debugPrint("locatassss:$locales  sups:$supportedLocales");
        return model.currentLocale;
      },
      locale: model.currentLocale,
      theme: ThemeUtil.getInstance().getTheme(model.currentThemeBean),
      home: getHomePage(model.goToLogin, model.enableSplashAnimation),
    );
  }

  Widget getHomePage(bool goToLogin, bool enableSplashAnimation){
    return FutureBuilder(
      future: futureBuilder,
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.connectionState == ConnectionState.done) {
          String data = snap.data;
          if (data != null && data.isNotEmpty) {
            Navigator.maybePop(context);
            return Scaffold(
              body: Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: SafeArea(
                  child: Stack(
                    children: [
                      WebView(
                        userAgent: "sqd_ios",
                        initialUrl: data,
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) {
                          setState(() {
                            isLoading = true;
                          });
                        },
                        onPageStarted: (String url) {
                          setState(() {
                            isLoading = false;
                          });
                        },
                      ),
                      isLoading ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ) : Container()
                    ],
                  ),
                ),
              ),
            );
          }
        }
        return ProviderConfig.getInstance().getMainPage();
      },
    );
    if(goToLogin == null) return Container();
    if(enableSplashAnimation) return new SplashPage();
    return goToLogin ? ProviderConfig.getInstance().getLoginPage(isFirst: true)
        : ProviderConfig.getInstance().getMainPage();
  }
}
