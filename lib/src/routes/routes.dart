
import 'package:flutter/material.dart';

import 'package:shareplace_flutter/src/pages/home_page.dart';
import 'package:shareplace_flutter/src/pages/info_page.dart';
import 'package:shareplace_flutter/src/pages/loans_page.dart';
import 'package:shareplace_flutter/src/pages/loans_historic_page.dart';
import 'package:shareplace_flutter/src/pages/login_page.dart';
import 'package:shareplace_flutter/src/pages/my_publications_page.dart';
import 'package:shareplace_flutter/src/pages/profile.dart';
import 'package:shareplace_flutter/src/pages/publication_detail_page.dart';
import 'package:shareplace_flutter/src/pages/requests_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    'home'                : (BuildContext context) => HomePage(),
    'login'               : (BuildContext context) => LoginPage(),
    'publicationDetail'   : (BuildContext context) => PublicationDetailPage(),
    'myPublications'      : (BuildContext context) => MyPublicationsPage(),
    'loans'               : (BuildContext context) => LoansPage(),
    'profile'             : (BuildContext context) => ProfilePage(),
    'loansHistoric'         : (BuildContext context) => LoansHistoricPage(),
    'requests'            : (BuildContext context) => RequestsPage(),
    'info'                : (BuildContext context) => InfoPage(),
  };
}
