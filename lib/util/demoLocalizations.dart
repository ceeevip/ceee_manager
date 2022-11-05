import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class DemoLocalizations {
  final Locale locale;//该Locale类是用来识别用户的语言环境

  DemoLocalizations(this.locale);
  //根据不同locale.languageCode 加载不同语言对应
  static Map<String,Map<String,String>> localizedValues = {
    //中文配置
    'zh':{
      'titlebar_title':'Flutter 例子主页面',
      'increment':'增加'
    },

    //英文配置
    'en':{
      'titlebar_title':'Flutter Demo Home Page',
      'increment':'Increment'
    }
  };

  //返回标题
  get titlebarTitle{
    return localizedValues[locale.languageCode]!['titlebar_title'];
  }

  //返回增加
  get increment{
    return localizedValues[locale.languageCode]!['increment'];
  }

  static DemoLocalizations of(BuildContext context){
    return Localizations.of(context, DemoLocalizations);
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','zh'].contains(locale.languageCode);
  }

  //DemoLocalizations就是在此方法内被初始化的。
  //通过方法的 locale 参数，判断需要加载的语言，然后返回自定义好多语言实现类DemoLocalizations
  //最后通过静态 delegate 对外提供 LocalizationsDelegate。
  @override
  SynchronousFuture<DemoLocalizations> load(Locale locale) {
    return SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalizations> old) {
    return false;
  }

  static LocalizationsDelegate delegate = const DemoLocalizationsDelegate();
}
