DROP DATABASE IF EXISTS Formula1;

CREATE DATABASE Formula1;
USE Formula1;
/*
tim (id_tim, id_SEF, pobjede, osvojeno_podija, sjediste, kod_sasija)
vozac(id_vozac, id_tim, ime, prezime, odabrani_broj, datum_rodenja, nacionalnost, osvojeno_naslova_prvaka, osvojeno_podija, osvojeno_bodova, odvozeno_najbrzih_krugova)
auto(id_auto, zavrseno_utrka, vrsta_motora, proizvodac_guma)
sponzor(id_sponzor, ime, isplacen_novac)
staza (id_staza, ime_staze, drzava, duzina, broj_drs_zona)
kvalifikacija(id_kvalifikacija, sesija_kvalifikacije, krugova_vozeno, izlazaka_na_stazu, datum)
trening (id_trening, odvozeno_krugova, najbrzi_krug, izlazaka_na_stazu, datum)
utrka(id_utrka, ime_nagrade, broj_krugova, vrijeme_vozeno, najbrzi_pitstop, datum)
sezona(id_sezona, prvak)
*/


-- DEKLARACIJA TABLICA // PROVJERITI!
CREATE TABLE tim(
   id_tim INTEGER PRIMARY KEY,
   naziv VARCHAR(50),
   voditelj VARCHAR(50),
   pobjede CHAR(5) NOT NULL,
   osvojeno_podija CHAR(5) NOT NULL,
   sjediste VARCHAR(50) NOT NULL,
   kod_sasija VARCHAR(30) NOT NULL,
   utrke CHAR(5)
);

CREATE TABLE vozac(
   id_vozac INTEGER PRIMARY KEY,
   id_tim INTEGER NOT NULL,
   id_auto INTEGER NOT NULL,
   ime VARCHAR(30) NOT NULL,
   prezime VARCHAR(30) NOT NULL,
   odabrani_broj INTEGER NOT NULL,
   datum_rodenja DATE NOT NULL, #fixat datum
   nacionalnost VARCHAR(30) NOT NULL,
   osvojeno_naslova_prvaka INTEGER NOT NULL,
   osvojeno_podija CHAR(5) NOT NULL,
   osvojeno_bodova CHAR(5) NOT NULL,
   odvozeno_najbrzih_krugova INTEGER NOT NULL,

   FOREIGN KEY (id_tim) REFERENCES tim(id)
);

  


CREATE TABLE automobil(
   id_auto INTEGER PRIMARY KEY,
   id_vozac INTEGER NOT NULL,
   zavrseno_utrka CHAR(5) NOT NULL ,
   vrsta_motora VARCHAR(40) NOT NULL,
   proizvodac_guma VARCHAR(30) NOT NULL
);

CREATE TABLE sponzor(
   id_sponzor INTEGER PRIMARY KEY,
   ime VARCHAR(20) NOT NULL,
   isplacen_novac INTEGER NOT NULL
);

CREATE TABLE staza(
   id_staza NUMERIC(4,0) PRIMARY KEY,
   ime_staze VARCHAR(50) NOT NULL,
   drzava VARCHAR(30) NOT NULL,
   duzina_m INTEGER NOT NULL,
   broj_drs_zona INTEGER NOT NULL
);

CREATE TABLE kvalifikacija(
   id_quali INTEGER PRIMARY KEY,
   sesija_kvalifikacije CHAR(5) NOT NULL,
   krugova_vozeno CHAR(5) NOT NULL,
   izlazaka_na_stazu CHAR(5) NOT NULL,
   datum DATE #fixat datum
);

CREATE TABLE trening(
   id_trening INTEGER PRIMARY KEY,
   odvozeno_krugova CHAR(5) NOT NULL,
   najbrzi_krug CHAR(5) NOT NULL,
   izlazaka_na_stazu CHAR(5) NOT NULL,
   datum DATE NOT NULL #datum fixat
);

CREATE TABLE utrka(
   id_utrka INTEGER PRIMARY KEY,
   ime_nagrade VARCHAR(30),
   pobjednik INTEGER,
   broj_krugova INTEGER NOT NULL,
   vrijeme_vozeno TIME NOT NULL, # fixat
   najbrzi_krug TIME NOT NULL,
   datum DATE NOT NULL, #fixat
   FOREIGN KEY (pobjednik) REFERENCES vozac(id)
);

CREATE TABLE sezona(
   id_sezona INTEGER PRIMARY KEY,
   prvak VARCHAR(30) NOT NULL
);


-- PROMJENE I OGRANIČENJA NA TABLICAMA
/* KAD DODAJETE OGRANICENJA SAMO COPY JEDAN OD OVIH I id_len_ck_2 ili  id_rng_ck_2 
I PAZITE NA ID KOD POJEDINIH RELACIJA <3
*/
ALTER TABLE staza
	ADD CONSTRAINT id_len_ck CHECK (length(id_staza) = 4),
   ADD CONSTRAINT id_rng_ck CHECK (id_staza >= 1000 AND id_staza <= 1999),
   ADD CONSTRAINT duzina_rng_ck CHECK (duzina_m >= 1000 AND duzina_m <= 99999);
   
ALTER TABLE tim
	ADD CONSTRAINT id_len_ck_1 CHECK (length(id_tim) = 3),
   ADD CONSTRAINT id_rng_ck_1 CHECK (id_tim >= 100 AND id_tim <= 999);

ALTER TABLE sponzor
   ADD CONSTRAINT id_len_ck_2 CHECK (length(id_sponzor) = 4),
   ADD CONSTRAINT id_rng_ck_2 CHECK (id_sponzor >= 4000 AND id_sponzor <= 4999),
   ADD CONSTRAINT payout_ck CHECK (isplacen_novac >= 500000);

ALTER TABLE utrka
   ADD CONSTRAINT id_len_ck_3 CHECK (length(id_utrka) = 4),
   ADD CONSTRAINT id_rng_ck_3 CHECK (id_utrka >= 3000 AND id_utrka <= 3999);
   
   
ALTER TABLE automobil
   ADD CONSTRAINT id_len_ck_4 CHECK (length(id_auto) = 4),
   ADD CONSTRAINT id_rng_ck_4 CHECK (id_auto >= 5000 AND id_auto <= 5999);
   
ALTER TABLE vozac
	ADD CONSTRAINT id_len_ck_5 CHECK (length(id_vozac) = 2),
   ADD CONSTRAINT id_rng_ck_5 CHECK (id_vozac >= 1 AND id_vozac <= 99);   




-- POPUNJAVANJE TABLICE // WIP 
INSERT INTO tim VALUES  
                        (101, 'McLaren F1 Team', 'Andreas Seidl', 182, 488, 'Woking, Surrey, Velika Britanija', 'MCL35M', 880),
                        (102, 'Mercedes AMG Petronas F1 Team', 'Toto Wolff', 124, 264, 'Brackley, Northamptonshire, Velika Britanija', 'Mercedes F1 W12', 249),
                        (103, 'Scuderia Ferrari', 'Mattia Binotto', 238, 778, 'Maranello, Italija', '	F1-75', 1030),
                        (104, 'Williams Racing', 'Jost Capito', 114, 312, 'Grove, Oxfordshire, Velika Britanija', 'Williams FW43', 744),
                        (105, 'Scuderia AlphaTauri Honda', 'Franz Tost', 1, 1, 'Faenza, Italija', 'AlphaTauri AT02', 17),
                        (106, 'Aston Martin Cognizant Formula One Team',' Lawrence Stroll I Otmar Szafnauer', 0, 1, 'Silverstone, Velika Britanija','Aston Martin AMR21', 11),
                        (107, 'Alpine F1 Team', 'Laurent Rossi / Davide Brivio', 1, 22, 'Enstone, Engleska, Velika Britanija', 'Alpine A521', 20),
                        (108, 'Sauber F1 Team', 'Monisha Kaltenborn', 0, 10, 'Hinwil, Švicarska', 'Sauber C37', 373),
                        (109, 'Force India F1 Team', 'Colin Kolles', 0, 6, 'Silverstone, Northamptonshire, Velika Britanija', 'Force India VJM11', 212),
                        (110, 'Red Bull Toro Rosso Honda', 'Franz Tost', 1, 2, 'Faenza, Italija', 'Toro Rosso STR14', 259),
                        (111, 'Haas F1 Team', 'Günther Steiner', 0, 0, 'Banbury, Oxfordshire, Velika Britanija', 'VF-22', 122),
                        (112, 'Manor Racing MRT', 'Dave Ryan', 0, 0, 'Banbury, Oxfordshire, Velika Britanija', 'MRT05', 21),
                        (113, 'Marussia F1 Team', 'John Booth', 0, 0, 'Banbury, Oxfordshire, Velika Britanija', 'MR03B', 74),
                        (114, 'HRT Formula 1 Team', 'Colin Kolles', 0, 0, 'Madrid, Španjolska', 'F112', 56),
                        (115, 'Caterham F1 Team', 'Tony Fernandes', 0, 0, 'Leafield, Oxfordshire, Velika Britanija', 'Caterham CT5', 94),
                        (116, 'Lotus F1 Team', 'Gérard Lopez', 2, 25, 'Enstone, Oxfordshire, Velika Britanija', 'E23', 77),
                        (117,'Red Bull Racing Oracle', 'Christian Horner', 62, 170, 'Christian Horner', 'Red Bull RB18',286),
                        (118,'Alfa Romeo Racing Orlen', 'Frédéric Vasseur', 10, 26, 'Hinwil, Švicarska', 'Alfa Romeo C39', 131),
                        (119,'Renault DP World F1 Team', 'Cyril Abiteboul', 35, 100, ' Enstone, Oxfordshire, Velika Britanija', 'Renault R.S.20', 383),
                        (120,'BWT Racing Point F1 Team',NULL, 1, 4, 'Silverstone, Velika Britanija', 'Racing Point RP19', 47)
					;

#ID JE U RANGU OD 1->99 MOZEMO POVECAT AKO ZAFALI
INSERT INTO vozac VALUES   /*2017*/
                           (1,  id_auto,  'Felipe', 'Massa', 19,  '25.4.1981.','brazilsko', 0, 41, 1167, 15),
                           (2,  id_auto,  'Jolyon', 'Palmer', 30,  '20.1.1991.','britansko', 0, 0, 35, 0),
                           (3,  id_auto,  'Pascal', 'Wehrlein', 94,  '18.10.1994.','njemačko', 0, 3, 6, 3),
                           (4,  id_auto,  'Daniil', 'Kvyat', 26,  '26.4.1994.','ruska', 0, 3, 202, 1),
                           (5,  id_auto,  'Antonio' , 'Giovinazzi', 99,  '14.12.1993.','talijanska', 0, 0, 21, 0),

                           /*2016*/
                           (6,  id_auto,  'Jenson', 'Button', 22,  '19.1.1980.','britanska', 1, 50, 1235, 8),                           
                           (7,  id_auto,  'Esteban', 'Gutierrez', 21,  '5.8.1991.','meksički', 0, 0, 6, 1),                           
                           (8,  id_auto,  'Rio', 'Haryanto', 88,  '22.1.1993.','indonezijsko', 0, 0, 0, 0),

                           /*2015*/
                           (9,  id_auto,  'Roberto', 'Merhi', 98,  '22.3.1991.','španjolsko', 0, 0, 0, 0),
                           (10, id_auto,  'Nico', 'Rosberg', 6,  '27.6.1985.','njemačko', 1, 57, 1594.5, 20),
                           (11, id_auto,  'Felipe', 'Nasr', 12,  '21.8.1992.','brazilsko', 0, 0, 29, 0),
                           (12, id_auto,  'Pastor', 'Maldonado', 13,  '9.3.1985.','venecuelanski', 0, 1, 76, 0),
                           (13, id_auto,  'Alexander', 'Rossi', 53,  '25.9.1991.','američko', 0, 25, osvojeno_bodova, odvozeno_najbrzih_krugova),
                           (14, id_auto,  'ime', 'prezime', odabrani_broj,  'datum_rodenja','nacionalnost', osvojeno_naslova_prvaka, osvojeno_podija, osvojeno_bodova, odvozeno_najbrzih_krugova),
                           (15, id_auto,  'ime', 'prezime', odabrani_broj,  'datum_rodenja','nacionalnost', osvojeno_naslova_prvaka, osvojeno_podija, osvojeno_bodova, odvozeno_najbrzih_krugova)
                           ;
##POKUŠAJTE DA ID OD AUTOMOBILA IDE NA ZNAMENKU OD VOZACA (5001-1)
INSERT INTO automobil VALUES 
						/*2012--2014*/
						(5000, id_vozac, 'V8', 'Pirelli'),
                        /*2015--danas*/
                        ##############
                        /*2017*/
						(5001, 1, 'V6 turbo hybrid'),
                        (5002, 2, 'V6 turbo hybrid'),
                        (5003, 3, 'V6 turbo hybrid'),
                        (5004, 4, 'V6 turbo hybrid'),
                        (5005, 5, 'V6 turbo hybrid'),
                        /*2016*/
                        (5006, 6, 'V6 turbo hybrid'),
                        (5007, 7, 'V6 turbo hybrid'),
                        (5008, 8, 'V6 turbo hybrid'),
                        
                        /*2015*/
                        (5009, 9, 'V6 turbo hybrid'),
                        (5010, 10, 'V6 turbo hybrid'),
                        (5011, 11, 'V6 turbo hybrid'),
                        (5012, 12, 'V6 turbo hybrid'),
                        (5013, 13, 'V6 turbo hybrid'),
                        (5014, 14, 'V6 turbo hybrid'),
                        (5015, 15, 'V6 turbo hybrid')
                        ;

-- SPONZORI // LISTA JE SMANJENA ZBOG OGROMNE KOLIČINE PODATAKA GLEDAJUĆI DA SVAKI TIM IMA PO MINIMALNO 20 SPONZORA.
INSERT INTO sponzor VALUES (4001, 'Petronas', 100000000),
                           (4002, 'Tommy Hilfiger', 24000000),
                           (4003, 'Monster Energy',56000000),
                           (4004, 'Oracle', 96500000),
                           (4005, 'Cash App', 76000000),
                           (4006, 'AT&T', 23760000),
                           (4007, 'Shell', 136758000),
                           (4008, 'Santander', 12000000),
                           (4009, 'VELAS', 57000000),
                           (4010, 'Snapdragon', 9000000),
                           (4011, 'Google', 194986000),
                           (4012, 'Dell', 29000000),
                           (4013, 'Alienware', 19000000),
                           (4014, 'Logitech G', 38760000),
                           (4015, 'SunGod', 560000),
                           (4016, 'BWT', 112000000),
                           (4017, 'RCI Bank and Services', 98760000),
                           (4018, 'Yahoo', 56000000),
                           (4019, 'Kappa', 780000),
                           (4020, 'Sprinklr', 520000),
                           (4021, 'AlphaTauri', 230670000),
                           (4022, 'Honda', 73187500),
                           (4023, 'Pirelli', 4167940000),
                           (4024, 'Ray Ban', 10000000),
                           (4025, 'Siemens', 13000000),
                           (4026, 'Aramco', 79000000),
                           (4027, 'TikTok', 20000000),
                           (4028, 'Hackett London',6780000),
                           (4029, 'Lavazza', 30000000),
                           (4030, 'DURACELL', 24000000),
                           (4031, 'Acronis', 53000000),
                           (4032, 'Alfa Romeo', 45600000),
                           (4033, 'PKN ORLEN', 39876500),
                           (4034, 'Iveco', 12000000),
                           (4035, 'Puma', 40123000),
                           (4036, 'Haas Automation', 36000000),
                           (4037, 'Maui Jim', 980760),
                           (4038, 'Alpinestars', 63000000),
                           (4039, 'TeamViewer', 5000000),
                           (4040, 'Richard Mille', 16400300),
                           (4041, 'Police', 5600000),
                           (4042, 'Philip Morris International', 13873900),
                           (4043, 'Rauch', 97655980),
                           (4044, 'UPS', 37000000),
                           (4045, 'Dupont', 19050000),
                           (4046, 'Marlboro', 160753100),
                           (4047, 'Martini', 75000000),
                           (4048, 'Rexona', 80000000),
                           (4049, 'NOVA Chemicals', 93000000),
                           (4050, 'TAGHeuer', 60000000);


-- STAZE // SVE OD 2012 DO 2022 // NEKE SU SE MJENJALE KROZ GODINE ALI "FOR SAKE OF BREVITY" NECEMO IH UBACIVATI KAO ODVOJENE STAZE.
INSERT INTO staza VALUES  (1001, 'Bahrain International Circuit 2005-2022', 'Sakhir, Bahrain', 5412, 3),
                          -- (1002, 'Jeddah Corniche Circuit', 'Jeddah, Saudi Arabia', 6174, 3),
                          (1003, 'Albert Park Circuit', 'Melbourne, Australia', 5278, 3),
                          -- (1004, 'Autodromo Enzo e Dino Ferrari 2008-2022', 'Imola, San Marino', 4909, 1),
                          -- (1005, 'Miami International Autodrome', 'Miami, USA', 5412, 3),
                          (1006, 'Circuit de Barcelona-Catalunya 2021-2022', 'Montmeló, Spain', 4675, 2),
                          (1007, 'Circuit de Monte Carlo 2015-2022', 'Monte Carlo, Monaco', 3337, 1),
                          (1008, 'Baku City Circuit', 'Baku, Azerbaijan', 6003, 2),
                          (1009, 'Circuit Gilles-Villeneuve', 'Montreal, Canada', 4361, 2),
                          (1010, 'Silverstone Circuit', 'Silverstone, UK', 5891, 2),
                          (1011, 'Red Bull Ring', 'Spielberg, Austria', 4318, 2),
                          (1012, 'Circuit Paul Ricard', 'Le Castellet, France', 5842, 2),
                          (1013, 'Hungaroring', 'Mogyoród, Hungary', 4381, 1),
                          (1014, 'Circuit Spa-Francorchamps', 'Stavelot, Belgium', 7004, 2),
                          -- (1015, 'Circuit Zandvoort', 'Zandvoort, Netherlands', 4259, 2),
                          (1016, 'Autodromo Nazionale Monza', 'Monza, Italy', 5793, 2),
                          (1017, 'Sochi Autodrom', 'Sochi, Russia', 5848, 2),
                          (1018, 'Marina Bay Circuit', 'Marina Bay, Singapore', 5063, 3),
                          (1019, 'Suzuka Circuit', 'Suzuka, Japan', 5807, 1),
                          (1020, 'Circuit of the Americas', 'Austin, USA', 5514, 2),
                          (1021, 'Autódromo Hermanos Rodríguez', 'Mexico City, Mexico', 4304, 1),
                          (1022, 'Autódromo José Carlos Pace', 'São Paulo, Brazil', 4309, 2),
                          (1023, 'Yas Marina Circuit', 'Yas Island', 5281, 2),
                          (1023, 'Autodromo do Algarve 2008-2022', 'Portimão, Portugal', 4653, 2),
                          -- (1024, 'Istanbul Park 2005-2022', 'Istanbul, Turkey', 5338, 2),
                          (1025, 'Losail International Circuit 2004-2022', 'Lusail, Qatar', 5380, 1),
                          -- (1026, 'Mugello 1974-2022', 'Scarperia e San Piero, Italy', 5245, 1),
                          (1027, 'Nürburgring 2002-2022', 'Nürburg, Germany', 5148, 2),
                          -- (1028, 'Bahrain International Circuit (OUTER)', 'Sakhir, Bahrain', 3543, 2),
                          (1029, 'Hockenheimring 2002-2022', 'Hockenheim, Germany', 4574, 2),
                          (1030, 'Shanghai International Circuit 2004-2022', 'Shanghai, China', 5451, 2),
                          (1031, 'Sepang International Circuit 1999-2022', 'Sepang, Malaysia', 5543, 2),
                          (1032, 'Korean International Circuit 2010-2022', 'Yeongam, South Korea', 5615, 2),
                          (1033, 'Buddh International Circuit 2011-2022', 'Greater Noida, India', 5125, 2),
                          (1034, 'Valencia Street Circuit 2008-2012', 'Valencia, Spain', 5419, 2);


INSERT INTO kvalifikacija  VALUES (id_kvalifikacija, sesija_kvalifikacije, krugova_vozeno, izlazaka_na_stazu, datum);
INSERT INTO trening  VALUES (id_trening, odvozeno_krugova, najbrzi_krug, izlazaka_na_stazu, datum);


-- UTRKE
INSERT INTO utrka  VALUES -- // GODINA: 2012 \\
                          (3001, '2012 Australia GP', pobjednik, 58, 01:34:09.565, 00:01:29.187, 2012-03-18),
                          (3002, '2012 Malaysia GP', pobjednik, 56, 02:44:51.812, 00:01:41.680, 2012-03-25),
                          (3003, '2012 China GP', pobjednik, 56, 01:36:26.929, 00:01:40.967, 2012-04-15),
                          (3004, '2012 Bahrain GP', pobjednik, 57, 01:35:10.990, 00:01:36.379, 2012-04-22),
                          (3005, '2012 Spain GP', pobjednik, 66, 01:39:09.145, 00:01:27.906, 2012-05-13),
                          (3006, '2012 Monaco GP', pobjednik, 78, 01:46:06.557, 00:01:18.805, 2012-05-27),
                          (3007, '2012 Canada GP', pobjednik, 70, 01:32:29.586, 00:01:15.752, 2012-06-10),
                          (3008, '2012 Europe GP', pobjednik, 57, 01:44:16.649, 00:01:42.163, 2012-06-24),
                          (3009, '2012 Great Britain GP', pobjednik, 52, 01:25:11.288, 00:01:34.934, 2012-07-08),
                          (3010, '2012 Germany GP', pobjednik, 67, 01:31:05.682, 00:01:19.044, 2012-07-22),
                          (3011, '2012 Hungary GP', pobjednik, 69, 01:41:05.503, 00:01:24.136, 2012-07-29),
                          (3012, '2012 Belgium GP', pobjednik, 44, 01:29:08.530, 00:01:52.822, 2012-09-02),
                          (3013, '2012 Italy GP', pobjednik, 53, 01:19:41.221, 00:01:27.239, 2012-09-09),
                          (3014, '2012 Singapore GP', pobjednik, 59, 02:00:26.144, 00:01:51.033, 2012-09-23),
                          (3015, '2012 Japan GP', pobjednik, 53, 01:28:56.242, 00:01:35.774, 2012-10-07),
                          (3016, '2012 Korea GP', pobjednik, 55, 01:36:28.651, 00:01:42.037, 2012-10-14),
                          (3017, '2012 India GP', pobjednik, 60, 01:31:10.77, 00:01:28.203, 2012-10-28),
                          (3018, '2012 Abu Dhabi GP', pobjednik, 55, 01:45:58.667, 00:01:43.964, 2012-11-04),
                          (3019, '2012 United States GP', pobjednik, 56, 01:35:55.269, 00:01:39.347, 2012-11-18),
                          (3020, '2012 Brazil GP', pobjednik, 71, 01:45:22.656, 00:01:18.069, 2012-11-25),
                          
--                         // GODINA: 2013 \\
                          (3002, '2013 Australia GP', pobjednik, 58, 01:30:03.225, 00:01:29.274, 2013-03-17),
                          (3002, '2013 Malaysia GP', pobjednik, 56, 01:38:56.681, 00:01:39.199, 2013-03-24),
                          (3002, '2013 China GP', pobjednik, 56, 01:36:26.945, 00:01:36.808, 2013-04-14),
                          (3002, '2013 Bahrain GP', pobjednik, 57, 01:36:00.498, 00:01:36.961, 2013-04-21),
                          (3002, '2013 Spain GP', pobjednik, 66, 01:39:16.596, 00:01:26.217, 2013-05-12),
                          (3002, '2013 Monaco GP', pobjednik, 78, 02:17:52.056, 00:01:18.133, 2013-05-26),
                          (3002, '2013 Canada GP', pobjednik, 70, 01:32:09.143, 00:01:16.182, 2013-06-09),
                          (3002, '2013 Great Britain GP', pobjednik, 52, 01:32:59.456, 00:01:33.401, 2013-06-30),
                          (3002, '2013 Germany GP', pobjednik, 60, 01:41:14.711, 00:01:33.468, 2013-07-07),
                          (3002, '2013 Hungary GP', pobjednik, 70, 01:42:29.445, 00:01:24.069, 2013-07-28),
                          (3002, '2013 Belgium GP', pobjednik, 44, 01:23:42.196, 00:01:50.756, 2013-08-25),
                          (3002, '2013 Italy GP', pobjednik, 53, 01:18:33.352, 00:01:25.849, 2013-09-08),
                          (3002, '2013 Singapore GP', pobjednik, , , , 2013-09-22),
                          (3002, '2013 Korea GP', pobjednik, , , , ),
                          (3002, '2013 Japan GP', pobjednik, , , , ),
                          (3002, '2013 India GP', pobjednik, , , , ),
                          (3002, '2013 Abu Dhabi GP', pobjednik, , , , ),
                          (3002, '2013 United States GP', pobjednik, , , , ),
                          (3002, '2013 Brazil GP', pobjednik, , , , ),
                          
--                         //GODINA: 2014 //
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),


-- SEZONE // 
INSERT INTO sezona  VALUES (id, prvak);
                           (2012, ),
                           (2013, ),
                           (2014, ),
                           (2015, ),
                           (2016, ),