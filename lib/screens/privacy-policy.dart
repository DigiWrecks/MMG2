import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/screens/home.dart';
import 'package:mydoctor/screens/login.dart';
import 'package:mydoctor/widgets/button.dart';
import 'package:mydoctor/widgets/custom-text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String email;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: 'Privacy Policy',),
      ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/mainback.png'),fit: BoxFit.fill)
          ),
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(35)),
            child: ListView(
              children: <Widget>[
                CustomText(
                  text: "Il rispetto per la privacy degli utenti, ovvero “medici di medicina generale” e “pediatri di libera scelta” (di seguito, per comodità, solo “medico”)"
                      " e pazienti loro assistiti, che utilizzeranno l’APP MEDICA  denominata “MMG”è fondamentale ed imprescindibile.\n"
                      "In queste pagine sono descritte le modalità"
                      " di gestione della APP Medica, anche in riferimento all’eventuale trattamento dei dati degli utenti che la utilizzano.\n"
                      "La presente informativa è resa ai"
                      " sensi dell’art. 13 del Regolamento UE 2016/679 e rivolta a coloro che utilizzeranno l’APP, nonché ai sensi dell’art. "
                      "14 del Regolamento Ue 2016/679 per i dati raccolti non presso l’interessato: nel caso di specie essa sarà destinata solo ed esclusivamente  all’utilizzo"
                      " dell’APP e non anche per altri servizi quali ad esempio la consultazione di dati sanitari personali.\n"
                      "Potranno fruire dei servizi messi a disposizione"
                      " dall’APP MEDICA i soggetti maggiorenni ed anche quelli che abbiano compiuto il sedicesimo anno d’età previo espresso consenso del genitore/soggetto"
                      " esercente la potestà genitoriale sul minore e dopo opportuna autocertificazione ai sensi di legge. Per i maggiorenni incapaci di intendere e volere"
                      " o per gli inabilitati sarà necessaria l’autorizzazione del soggetto Tutore/Curatore.\n"
                      "Per i minori degli anni sedici, il consenso dovrà essere espresso"
                      " dal genitore o esercente la potestà genitoriale dopo opportuna autocertificazione ai sensi di legge.",
                  align: TextAlign.justify,
                  isBold: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
                  child: CustomText(
                    text: "A) Informativa",
                    size: ScreenUtil().setSp(32),
                  ),
                ),
                CustomText(
                  text: "Il presente documento ha lo scopo di:\n"
                      "1.	descrivere quali dati personali e quali categorie particolari di dati personali sono eventualmente scambiati nell’ambito dell’APP, le finalità e le modalità di trattamento, le misure di sicurezza adottate;\n"
                      "2.	consentire a ciascun utente di prestare un consenso consapevole al trattamento dei suoi dati, ove detto consenso debba essere raccolto per legge.",
                  align: TextAlign.justify,
                  isBold: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
                  child: CustomText(
                    text: "B)	Finalità del trattamento e base giuridica",
                    size: ScreenUtil().setSp(32),
                  ),
                ),
                CustomText(
                  text: "Il trattamento dei dati effettuato ha le seguenti finalità:\n"
                      "1.	consentire l’utilizzo dell’APP ai fini di agevolare la comunicazione “medico” – paziente per il raggiungimento di una o più finalità determinate ed esplicitamente connesse alla cura della salute e della persona.\n"
                      "Per i trattamenti soggetti a consenso dell’utente, la base giuridica del trattamento si identifica, appunto, nel consenso prestato dall’utente prima dell’utilizzo dell’APP MEDICA.",
                  align: TextAlign.justify,
                  isBold: false,
                ),
                CustomText(
                  text: "Per nessuna ragione i dati dei pazienti raccolti, custoditi e conservati nel Fascicolo Sanitario Elettronico e Dossier Sanitario Elettronico potranno"
                      " confluire nell’APP MEDICA, che a tal proposito userà un linguaggio software non compatibile con gli altri.",
                ),
                CustomText(
                  text: "Salvo che non ci sia espresso consenso del paziente, le credenziali dell’APP MEDICA, nel caso in cui il “medico” non dovesse essere reperibile,"
                      " non saranno comunicate o trasmesse ad altri sanitari. Qualora il paziente, volontariamente volesse usufruire dei servizi di cui all’APP MEDICA"
                      " con altro medico, dovrà scarica altra APP riferita a quest’ultimo e prestare idoneo consenso",
                  align: TextAlign.justify,
                  isBold: false,
                ),
                CustomText(
                  text: "Naturalmente la tutela e la conservazione dei dati raccolti sarà quella applicata all’APP MEDICA.",
                  align: TextAlign.justify,
                  isBold: false,
                  isUnderlined: true,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
                  child: CustomText(
                    text: "C)	Modalità di trattamento dei dati",
                    size: ScreenUtil().setSp(32),
                  ),
                ),
                CustomText(
                  text: "I dati sono trattati prevalentemente con strumenti informatici, per il tempo strettamente necessario a conseguire gli scopi per cui sono stati"
                      " raccolti.\nSpecifiche misure tecniche e organizzative dell’APP MEDICA sono osservate per garantire un livello di sicurezza adeguato, in conformità a"
                      " quanto previsto dall’art. 32 Regolamento UE 2016/679.",
                  align: TextAlign.justify,
                  isBold: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
                  child: CustomText(
                    text: "D)	Dati trattati",
                    size: ScreenUtil().setSp(32),
                  ),
                ),
                CustomText(
                  text: "Prima di iniziare ad utilizzare l’APP MEDICA, il paziente dovrà esprimere esplicito consenso al trattamento dei dati, sottoscrivendo il presente modulo"
                      " in presenza del medico, o quando scaricherà l’APP sul suo dispositivo\n"
                      "Per il rilascio del consenso, l’utente dovrà comunicare il proprio numero di"
                      " cellulare e le informazioni di base per creare un proprio account con una password, avendo cura di non diffonderla e che dovrà essere custodita"
                      " attentamente dal paziente. Sarà altresì sua responsabilità accertarsi che il proprio telefono dispositivo cellulare non venga smarrito, lasciato"
                      " incustodito e/o reso accessibile a terzi.\n"
                      "Sarà ancora esclusiva responsabilità del paziente l’eventuale pubblicazione/trasmissione VOLONTARIA di"
                      " categorie particolari di dati personali ( a titolo puramente indicativo ma non esaustivo esiti  di esami e/o visite specialistiche)  qualora liberamente"
                      " decida di condividere tali contenuti. Il loro trattamento avverrà negli stretti limiti in cui si renda necessario comunicarli  al “Medico” .\n"
                      "Gli accessi tramite l’APP MEDICA non potranno esser utilizzati o in alcun modo registrati per raccogliere informazioni sui pazienti stessi, nemmeno"
                      " tramite cookies.\nL’APP MEDICA non conterrà banner pubblicitari di terzi, né messaggi commerciali, nemmeno per categorie di prodotti per la cura della"
                      " persona.",
                  align: TextAlign.justify,
                  isBold: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
                  child: CustomText(
                    text: "E)	Visibilità dei dati",
                    size: ScreenUtil().setSp(32),
                  ),
                ),
                CustomText(
                  text: "I dati saranno trasmessi dall’utente al “medico” e viceversa con modalità crittografata secondo lo standard end-to-end.\n"
                      "La crittografia"
                      " end-to-end significa che i messaggi degli utenti (medico e paziente) saranno  criptati, potranno essere letti solo da mittente e destinatario"
                      " e non potranno essere intellegibili per  terzi soggetti.",
                  align: TextAlign.justify,
                  isBold: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
                  child: CustomText(
                    text: "F)	Comunicazione e diffusione dei dati",
                    size: ScreenUtil().setSp(32),
                  ),
                ),
                CustomText(
                  text: "I dati raccolti saranno trattati per le sole finalità di cui alla presente informativa.\n"
                      "Senza il consenso espresso dell’utente/paziente,"
                      " il “medico”, quale soggetto responsabile dei dati, potrà comunicare gli stessi a tutti i soggetti ai quali la comunicazione sia obbligatoria"
                      " per legge e, in ogni caso, ai soggetti autorizzati al trattamento.\n"
                      "I dati degli utenti non saranno diffusi a terzi.\nL’APP MEDICA non raccoglie"
                      " informazioni sulla posizione del dispositivo anche se l'utente usa le funzioni relative alla geolocalizzazione dello stesso.",
                  align: TextAlign.justify,
                  isBold: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
                  child: CustomText(
                    text: "G)	Conservazione dei dati",
                    size: ScreenUtil().setSp(32),
                  ),
                ),
                CustomText(
                  text: "I dati sono conservati su server che si trovano in Italia o Paesi esteri, i quali, qualora extra UE, dovranno garantire l’adeguamento al regime"
                      " di Privacy Shield ovvero aver adottato forme convenzionali di adeguamento che prevedano misure di protezione non inferiori a quelle previste per"
                      " il territorio italiano.\n"
                      "I dati sono conservati per il periodo di tempo strettamente necessario a perseguire le finalità sopra esplicate e per la"
                      " durata del servizio richiesto dall’utenza, e comunque nel rispetto della normativa vigente.\n"
                      "L’account potrà essere cancellato  su richiesta"
                      " dell’utente rivolta direttamente al “Medico”.",
                  align: TextAlign.justify,
                  isBold: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
                  child: CustomText(
                    text: "H)	Revoca del consenso",
                    size: ScreenUtil().setSp(32),
                  ),
                ),
                CustomText(
                  text: "Il paziente è libero di revocare il consenso in qualsiasi momento, inviando una comunicazione mediante raccomandata a.r. o mezzo equipollente dal"
                      " quale sia possibile evincere la data di ricevimento della stessa. La comunicazione di cui sopra dovrà essere inviata al “medico” a cui l’APP MEDICA"
                      " si riferisce.",
                  align: TextAlign.justify,
                  isBold: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
                  child: CustomText(
                    text: "I)	Modifiche",
                    size: ScreenUtil().setSp(32),
                  ),
                ),
                CustomText(
                  text: "Il responsabile del trattamento e della conservazione si riserva il diritto di apportare delle modifiche e/o di aggiornare questo documento,"
                      " che sarà reso disponibile nell’apposita sezione dell’APP.",
                  align: TextAlign.justify,
                  isBold: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
                  child: CustomText(
                    text: "L)	Diritti dell’interessato",
                    size: ScreenUtil().setSp(32),
                  ),
                ),
                CustomText(
                  text: "I soggetti cui si riferiscono i dati hanno il potere di esercitare in qualunque momento i diritti di cui agli artt. 15 – 22 Regolamento UE 2016/679.\n"
                      "In particolare, si tratta, in quanto applicabili:\n"
                      "1.	del diritto di ottenere dal Titolare del trattamento la conferma che sia in corso o meno un"
                      " trattamento dei dati personali dell’interessato unitamente alle informazioni di cui all’art. 15 del Regolamento UE 2016/679;\n"
                      "2.	del diritto di rettifica"
                      " dei dati personali inesatti che riguardano l’interessato stesso;\n"
                      "3.	del diritto alla cancellazione dei dati personali (c.d. diritto all’oblio) nei casi"
                      " normativamente previsti dall’art. 17 del Regolamento UE 2016/679;\n"
                      "4.	del diritto di limitazione del trattamento, al ricorrere di una delle ipotesi di cui"
                      " all’art. 18 del Regolamento UE 2016/679;\n"
                      "5.	del diritto di ricevere in formato strutturato, di uso comune e leggibile da dispositivo automatico i dati"
                      " personali, che riguardano l’interessato, forniti al Titolare del trattamento, nonché del diritto di trasmettere tali dati a un altro Titolare del"
                      " trattamento senza impedimenti (c.d. diritto alla portabilità dei dati, art. 20 del Regolamento UE 2016/679);\n"
                      "6.	del diritto di opposizione al trattamento"
                      " dei dati personali che riguardano l’interessato (art. 21 del Regolamento UE 2016/679);\n"
                      "7.	del diritto di non essere sottoposto a decisioni basate"
                      " unicamente su trattamenti automatizzati, compresa la profilazione, che producano effetti giuridici che riguardano l’interessato o che incidano in modo"
                      " analogo e significativamente sulla sua persona (art. 22 del Regolamento UE 2016/679);\n"
                      "8.	del diritto di proporre reclamo all’autorità di controllo"
                      " (Autorità Garante per la Protezione dei dati personali, con sede in Piazza di Monte Citorio n. 121 – 00186 Roma).Le richieste potranno essere"
                      " rivolte:\n"
                      " -	via mail, all’indirizzo  del “Medico”\n"
                      " -	oppure per posta, all’indirizzo:  dott. Tizio, via Bianchi",
                  align: TextAlign.justify,
                  isBold: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
                  child: CustomText(
                    text: "M)	Titolare del trattamento e Responsabile della Protezione dei Dati Personali è:",
                    size: ScreenUtil().setSp(32),
                  ),
                ),
                CustomText(
                  text: "il DOTTORE\n\n"
                      "Il sottoscritto, in proprio o in qualità di tutore, amministratore di sostegno, curatore o esercente la potestà genitoriale, o familiare delegato dichiara di aver letto, ricevuto i necessari chiarimenti ed aver accettato le condizioni di cui alla presente informativa, in particolare alle lettere A,B,C, D, E, F,G,H,I, L e M, composta da n. 2 fogli compreso il presente",
                  align: TextAlign.justify,
                  isBold: false,
                ),


                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(45)),
                  child: Button(
                    text: 'Chiudi',
                    color: Colors.green,
                    onclick: (){
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => email==null?LogIn():Home()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
