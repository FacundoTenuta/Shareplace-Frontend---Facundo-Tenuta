
import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/pages/edit_publication_page.dart';

import 'package:shareplace_flutter/src/pages/home_page.dart';
import 'package:shareplace_flutter/src/pages/info_page.dart';
import 'package:shareplace_flutter/src/pages/loan_detail_page.dart';
import 'package:shareplace_flutter/src/pages/loans_page.dart';
import 'package:shareplace_flutter/src/pages/loans_historic_page.dart';
import 'package:shareplace_flutter/src/pages/login_page.dart';
import 'package:shareplace_flutter/src/pages/my_publication_detail_page.dart';
import 'package:shareplace_flutter/src/pages/my_publications_page.dart';
import 'package:shareplace_flutter/src/pages/new_publication_page.dart';
import 'package:shareplace_flutter/src/pages/other_profile_page.dart';
import 'package:shareplace_flutter/src/pages/profile.dart';
import 'package:shareplace_flutter/src/pages/publication_detail_page.dart';
import 'package:shareplace_flutter/src/pages/request_received_detail_page.dart';
import 'package:shareplace_flutter/src/pages/request_sent_detail_page.dart';
import 'package:shareplace_flutter/src/pages/requests_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    'home'                  : (BuildContext context) => HomePage(),
    'login'                 : (BuildContext context) => LoginPage(),
    'publicationDetail'     : (BuildContext context) => PublicationDetailPage(),
    'myPublications'        : (BuildContext context) => MyPublicationsPage(),
    'myPublicationsDetail'  : (BuildContext context) => MyPublicationDetailPage(),
    'editPublicationPage'   : (BuildContext context) => EditPublicationPage(),
    'newPublicationPage'    : (BuildContext context) => NewPublicationPage(),
    'loans'                 : (BuildContext context) => LoansPage(),
    'loanDetail'            : (BuildContext context) => LoanDetailPage(),
    'profile'               : (BuildContext context) => ProfilePage(),
    'otherProfile'          : (BuildContext context) => OtherProfilePage(),
    'loansHistoric'         : (BuildContext context) => LoansHistoricPage(),
    'requests'              : (BuildContext context) => RequestsPage(),
    'requestSentDetail'     : (BuildContext context) => RequestSentDetailPage(),
    'requestReceivedDetail' : (BuildContext context) => RequestReceivedDetailPage(),
    'info'                  : (BuildContext context) => InfoPage(),
  };
}
