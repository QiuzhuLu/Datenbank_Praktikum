DROP TABLE Miete;
DROP TABLE Zahlungsmittel;
DROP TABLE Fahrer;
DROP TABLE Fahrzeug;
DROP TABLE Fahrzeugtyp;
DROP TABLE Fahrzeuganbieter;
DROP TYPE stempel;

-- Erstellen
CREATE TYPE stempel AS OBJECT (
   Zeitstempel DATE,
   KilometerGesamt int,
   Standort VARCHAR(50)
);
/

CREATE TABLE Fahrzeuganbieter(
    Name VARCHAR(100) NOT NULL,
    Adresse VARCHAR(200) NOT NULL,
    CONSTRAINT pk_fahrzeuganbieter PRIMARY KEY(Name)
);

CREATE TABLE Fahrzeugtyp(
    Mindestalter int NOT NULL,
    Bezeichnung VARCHAR(100) NOT NULL,
    Kilometerpreis DECIMAL NOT NULL,
    Minutenpreis DECIMAL NOT NULL,
    Antriebsart VARCHAR(20),
    Plaetze int,
    Transportvolumen int,
    Schaltung VARCHAR(20),
    Fahrzeugart VARCHAR(20) NOT NULL,
    Hersteller VARCHAR(20) NOT NULL,
    Modell VARCHAR(20) NOT NULL,
    MaxReichweite int NOT NULL,
    CONSTRAINT pk_Fahrzeugtyp primary key(Bezeichnung, Hersteller, Modell)
);

CREATE TABLE Fahrzeug( 
    Kennzeichen VARCHAR(20) NOT NULL,
    Name VARCHAR(20) NOT NULL,
    Fuellstand INTEGER NOT NULL,
    Standort VARCHAR(50) NOT NULL,
    Sauberkeit INTEGER NOT NULL,
    KilometerGesamt INTEGER,
    Anbieter VARCHAR(50) NOT NULL,
    TypBezeichnung VARCHAR(100) NOT NULL,
    TypHersteller VARCHAR(20) NOT NULL,
    TypModell VARCHAR(20) NOT NULL,
    CONSTRAINT pk_fahrzeug PRIMARY KEY (Kennzeichen),
    CONSTRAINT fk_fahrzeug_anbieter FOREIGN KEY(Anbieter) 
                                    REFERENCES Fahrzeuganbieter(Name),
    CONSTRAINT fk_Fahrzeug_Modell FOREIGN KEY(TypBezeichnung, TypHersteller, TypModell) 
                                    REFERENCES Fahrzeugtyp(Bezeichnung, Hersteller, Modell),
    CONSTRAINT fuellstand_prozent check(Fuellstand >= 0 and Fuellstand <= 100),
    CONSTRAINT sauberkeit_prozent check(Fuellstand >= 0 and Fuellstand <= 100)
);

CREATE TABLE Fahrer(
    Passwort VARCHAR(1024) NOT NULL,
    EMailadresse VARCHAR(60) NOT NULL,
    Vorname VARCHAR(30) NOT NULL,
    Nachname VARCHAR(50) NOT NULL,
    Adresse VARCHAR(100) NOT NULL,
    Fuehererscheinklassen VARCHAR(20),
    Fuehrerscheindatum DATE,
    Geburtsdatum DATE NOT NULL,
    Lieblingsfahrzeug VARCHAR(20),
    CONSTRAINT fk_fahrzeug FOREIGN KEY(Lieblingsfahrzeug) REFERENCES Fahrzeug(Kennzeichen),
    CONSTRAINT pk_fahrer PRIMARY KEY (EMailadresse)
);

CREATE TABLE Zahlungsmittel(
    Bezeichnung VARCHAR(100) NOT NULL,
    Typ VARCHAR(50) NOT NULL,
    Zahlungsmitteldaten VARCHAR(200) NOT NULL,
    Fahreremail VARCHAR(60) NOT NULL,
    CONSTRAINT fk_zahlungsmittel_fahrer FOREIGN KEY(Fahreremail) REFERENCES Fahrer(EMailadresse),
    CONSTRAINT pk_zahlungsmittel PRIMARY KEY (Fahreremail, Bezeichnung)   
);

CREATE TABLE Miete(
    ID RAW(16) NOT NULL,
    von stempel NOT NULL,
    bis stempel,
    Preis DECIMAL,
    Fahreremail VARCHAR(60) NOT NULL,
    Fahrzeug VARCHAR(20) NOT NULL,
    Zahlungsmittel VARCHAR(100) NOT NULL,
    CONSTRAINT fk_miete_fahrer FOREIGN KEY(Fahreremail) REFERENCES Fahrer(EMailadresse),
    CONSTRAINT fk_miete_fahrzeug FOREIGN KEY(Fahrzeug) REFERENCES Fahrzeug(Kennzeichen),
    CONSTRAINT pk_miete PRIMARY KEY(ID),
    CONSTRAINT fk_bezahlt_mit FOREIGN KEY(Fahreremail, Zahlungsmittel) REFERENCES Zahlungsmittel(Fahreremail, Bezeichnung)
);


INSERT INTO Fahrzeuganbieter(Name, Adresse) VALUES ('Rent-A-Hovercraft', 'Rutschbahn 23, 12345 Hoffnungstal');
INSERT INTO Fahrzeuganbieter(Name, Adresse) VALUES ('Fahrradverleih Klingeling', 'Rabumsel 42, 23456 Paradies');
INSERT INTO Fahrzeuganbieter(Name, Adresse) VALUES ('Verbrennungsmotoren-wir glauben noch immer dran', 'CDU-Weg 23, 34567 Vergangenheit');
INSERT INTO Fahrzeuganbieter(Name, Adresse) VALUES ('ElbShare', 'Dock 7, 12345 Hamburg');
INSERT INTO Fahrzeuganbieter(Name, Adresse) VALUES ('Bizzel', 'Am E-Werk 42, 50000 Volt');

INSERT INTO FahrzeugTyp(
    Mindestalter, 
    Bezeichnung, 
    Kilometerpreis, 
    Minutenpreis, 
    Antriebsart, 
    Plaetze, 
    Transportvolumen, 
    Schaltung,
    Fahrzeugart, 
    Hersteller,
    Modell,
    MaxReichweite)
    VALUES(
        25,
        'Standard',
        1.5,
        1,
        'Riesenpropeller',
        2,
        40,
        'Automatik',
        'Hovercraft',
        'Crafting Hovers',
        'HC2P',
        100
    );

INSERT INTO FahrzeugTyp(
    Mindestalter, 
    Bezeichnung, 
    Kilometerpreis, 
    Minutenpreis, 
    Antriebsart, 
    Plaetze, 
    Transportvolumen, 
    Schaltung,
    Fahrzeugart, 
    Hersteller,
    Modell,
    MaxReichweite)
    VALUES(
        25,
        'Party',
        1.5,
        2,
        'Riesenpropeller',
        4,
        20,
        'Automatik',
        'Hovercraft',
        'Crafting Hovers',
        'HC2P',
        100
    );

INSERT INTO FahrzeugTyp(
    Mindestalter, 
    Bezeichnung, 
    Kilometerpreis, 
    Minutenpreis, 
    Antriebsart, 
    Plaetze, 
    Transportvolumen, 
    Schaltung,
    Fahrzeugart, 
    Hersteller,
    Modell,
    MaxReichweite)
    VALUES(
        25,
        'Lasten',
        3,
        0.5,
        'Riesenpropeller',
        2,
        200,
        'Automatik',
        'Hovercraft',
        'Crafting Hovers',
        'HC2T',
        80
    );
INSERT INTO FahrzeugTyp(
    Mindestalter, 
    Bezeichnung, 
    Kilometerpreis, 
    Minutenpreis, 
    Antriebsart, 
    Plaetze, 
    Transportvolumen, 
    Schaltung,
    Fahrzeugart, 
    Hersteller,
    Modell,
    MaxReichweite)
    VALUES(
        12,
        'ElektroFahrrad',
        0,
        0.05,
        'ElektroKraft',
        1,
        0,
        '21 Gang',
        'Fahrrad',
        'Alhonga',
        'Modell1',
        1000
    );
    
INSERT INTO FahrzeugTyp(
    Mindestalter, 
    Bezeichnung, 
    Kilometerpreis, 
    Minutenpreis, 
    Antriebsart, 
    Plaetze, 
    Transportvolumen, 
    Schaltung,
    Fahrzeugart, 
    Hersteller,
    Modell,
    MaxReichweite)
    VALUES(
        8, 
        'Rennrad',
        0,
        0.01,
        'Muskelkraft',
        1,
        0,
        '21 Gang',
        'Fahrrad',
        'Campagnolo',
        'Modell2',
        1000
    );
    
INSERT INTO FahrzeugTyp(
    Mindestalter, 
    Bezeichnung, 
    Kilometerpreis, 
    Minutenpreis, 
    Antriebsart, 
    Plaetze, 
    Transportvolumen, 
    Schaltung,
    Fahrzeugart, 
    Hersteller,
    Modell,
    MaxReichweite)
    VALUES(
        18,
        'Knutschkugel',
        0.15,
        0.30,
        'Benzin',
        4,
        100,
        '5 Gang',
        'PKW',
        'Fiat',
        '500',
        600
    );

INSERT INTO FahrzeugTyp(
    Mindestalter, 
    Bezeichnung, 
    Kilometerpreis, 
    Minutenpreis, 
    Antriebsart, 
    Plaetze, 
    Transportvolumen, 
    Schaltung,
    Fahrzeugart, 
    Hersteller,
    Modell,
    MaxReichweite)
    VALUES(
        25,
        'emotionaler Motorsound',
        0.30,
        0.50,
        'Benzin',
        4,
        300,
        '6 Gang',
        'SUV',
        'Mercedes',
        'AMG GLC 43 4Matic',
        1000
    );

INSERT INTO FahrzeugTyp(
    Mindestalter, 
    Bezeichnung, 
    Kilometerpreis, 
    Minutenpreis, 
    Antriebsart, 
    Plaetze, 
    Transportvolumen, 
    Schaltung,
    Fahrzeugart, 
    Hersteller,
    Modell,
    MaxReichweite)
    VALUES(
        16,
        'why walk?',
        0.30,
        0.40,
        'Elektrisch',
        1,
        0,
        'Automatik',
        'E-Scooter',
        'tier',
        'CityScooter',
        100
    );

INSERT INTO FahrzeugTyp(
    Mindestalter, 
    Bezeichnung, 
    Kilometerpreis, 
    Minutenpreis, 
    Antriebsart, 
    Plaetze, 
    Transportvolumen, 
    Schaltung,
    Fahrzeugart, 
    Hersteller,
    Modell,
    MaxReichweite)
    VALUES(
        18,
        'CityKatamaran',
        0.30,
        0.40,
        'Wind',
        1,
        0,
        'Automatik',
        'Katamaran',
        'Nautitech',
        'Kata1',
        2000
    );


INSERT INTO Fahrzeug (
    Kennzeichen,
    Name, 
    Fuellstand, 
    Standort, 
    Sauberkeit, 
    KilometerGesamt, 
    Anbieter, 
    TypBezeichnung, 
    TypHersteller, 
    TypModell) 
    VALUES(
    'HH - CH 1234',
    'Sylvester',
    100,
    '53.534809, 9.823545',
    100,
    240,
    'Rent-A-Hovercraft',
    'Party',
    'Crafting Hovers',
    'HC2P'
);

INSERT INTO Fahrzeug (
    Kennzeichen,
    Name, 
    Fuellstand, 
    Standort, 
    Sauberkeit, 
    KilometerGesamt, 
    Anbieter, 
    TypBezeichnung, 
    TypHersteller, 
    TypModell) 
    VALUES(
    'HH - CH 1235',
    'Jason',
    100,
    '53.545401, 9.963184',
    100,
    10,
    'Rent-A-Hovercraft',
    'Party',
    'Crafting Hovers',
    'HC2P'
);

INSERT INTO Fahrzeug (
    Kennzeichen,
    Name, 
    Fuellstand, 
    Standort, 
    Sauberkeit, 
    KilometerGesamt, 
    Anbieter, 
    TypBezeichnung, 
    TypHersteller, 
    TypModell) 
    VALUES(
    'HH - CH 1236',
    'Dwayne',
    100,
    '53.534809, 9.823545',
    100,
    10,
    'Rent-A-Hovercraft',
    'Lasten',
    'Crafting Hovers',
    'HC2T'
);

INSERT INTO Fahrzeug (
    Kennzeichen,
    Name, 
    Fuellstand, 
    Standort, 
    Sauberkeit, 
    KilometerGesamt, 
    Anbieter, 
    TypBezeichnung, 
    TypHersteller, 
    TypModell) 
    VALUES(
    'HH - KAT 001',
    'Hindenburg',
    100,
    '53.545401, 9.963184',
    100,
    450,
    'ElbShare',
    'CityKatamaran',
    'Nautitech',
    'Kata1'
);

INSERT INTO Fahrzeug (
    Kennzeichen,
    Name, 
    Fuellstand, 
    Standort, 
    Sauberkeit, 
    KilometerGesamt, 
    Anbieter, 
    TypBezeichnung, 
    TypHersteller, 
    TypModell) 
    VALUES(
    'HH - EF 001',
    'Tante Vera',
    100,
    '53.123422, 9.123544',
    100,
    603,
    'Fahrradverleih Klingeling',
    'ElektroFahrrad',
    'Alhonga',
    'Modell1'
);

INSERT INTO Fahrzeug (
    Kennzeichen,
    Name, 
    Fuellstand, 
    Standort, 
    Sauberkeit, 
    KilometerGesamt, 
    Anbieter, 
    TypBezeichnung, 
    TypHersteller, 
    TypModell) 
    VALUES(
    'F234231',
    'Karla Kolumna',
    100,
    '53.545401, 9.963184',
    100,
    1390,
    'Fahrradverleih Klingeling',
    'Rennrad',
    'Campagnolo',
    'Modell2'
);

INSERT INTO Fahrzeug (
    Kennzeichen,
    Name, 
    Fuellstand, 
    Standort, 
    Sauberkeit, 
    KilometerGesamt, 
    Anbieter, 
    TypBezeichnung, 
    TypHersteller, 
    TypModell) 
    VALUES(
    'HH - AF 203',
    'Heiner',
    100,
    '53.534809, 9.823545',
    100,
    23054,
    'Verbrennungsmotoren-wir glauben noch immer dran',
    'emotionaler Motorsound',
    'Mercedes',
    'AMG GLC 43 4Matic'
);

INSERT INTO Fahrzeug (
    Kennzeichen,
    Name, 
    Fuellstand, 
    Standort, 
    Sauberkeit, 
    KilometerGesamt, 
    Anbieter, 
    TypBezeichnung, 
    TypHersteller, 
    TypModell) 
    VALUES(
    'HH - AF 204',
    'Bernd',
    100,
    '53.502809, 9.823545',
    100,
    10054,
    'Verbrennungsmotoren-wir glauben noch immer dran',
    'emotionaler Motorsound',
    'Mercedes',
    'AMG GLC 43 4Matic'
);

INSERT INTO Fahrzeug (
    Kennzeichen,
    Name, 
    Fuellstand, 
    Standort, 
    Sauberkeit, 
    KilometerGesamt, 
    Anbieter, 
    TypBezeichnung, 
    TypHersteller, 
    TypModell) 
    VALUES(
    'HH - KK 105',
    'Sybille',
    100,
    '53.534234, 9.823545',
    100,
    30054,
    'Verbrennungsmotoren-wir glauben noch immer dran',
    'Knutschkugel',
    'Fiat',
    '500'
);

INSERT INTO Fahrzeug (
    Kennzeichen,
    Name, 
    Fuellstand, 
    Standort, 
    Sauberkeit, 
    KilometerGesamt, 
    Anbieter, 
    TypBezeichnung, 
    TypHersteller, 
    TypModell) 
    VALUES(
    'HH - KK 106',
    'Henriette',
    100,
    '53.535134, 9.822045',
    100,
    12054,
    'Verbrennungsmotoren-wir glauben noch immer dran',
    'Knutschkugel',
    'Fiat',
    '500'
);

INSERT INTO Fahrer (
    Passwort,
    EMailadresse,
    Vorname,
    Nachname,
    Adresse,
    Fuehererscheinklassen,
    Fuehrerscheindatum,
    Geburtsdatum,
    Lieblingsfahrzeug) 
        VALUES(
        '123455aa',
        'LukasMustermann12@gmail.com',
        'Lukas',
        'Mustermann',
        'Berliner Tor 24, 20099 Hamburg',
        'B',
        TO_DATE('2021-01-01', 'yyyy-mm-dd'),
        TO_DATE('1998-02-01', 'yyyy-mm-dd'),
        'HH - KK 106'
    );

INSERT INTO Fahrer (
    Passwort,
    EMailadresse,
    Vorname,
    Nachname,
    Adresse,
    Fuehererscheinklassen,
    Fuehrerscheindatum,
    Geburtsdatum,
    Lieblingsfahrzeug) 
        VALUES(
        '0x3EDC80CACD94D281014EBCF6688F1A662890C171CEA2EA0CA2D4A2705991126E0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
        'MaxiMauke@gmail.com',
        'Maximilian',
        'Maukesson',
        'Musterweg 3, 33562 Holstedt',
        'A1,B',
        TO_DATE('2002-05-10', 'yyyy-mm-dd'),
        TO_DATE('1982-03-12', 'yyyy-mm-dd'),
        NULL
    );

INSERT INTO Fahrer (
    Passwort,
    EMailadresse,
    Vorname,
    Nachname,
    Adresse,
    Fuehererscheinklassen,
    Fuehrerscheindatum,
    Geburtsdatum,
    Lieblingsfahrzeug) 
    VALUES(
        '0x31323231323433353736000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
        'xX360noscoperXx@gmail.com',
        'Jens',
        'Hinger',
        'Haunusweg 3, 23485 Tölbruch',
        'A1',
        TO_DATE('2016-05-10', 'yyyy-mm-dd'),
        TO_DATE('1999-03-12', 'yyyy-mm-dd'),
        NULL
    );
    
INSERT INTO Fahrer (
    Passwort,
    EMailadresse,
    Vorname,
    Nachname,
    Adresse,
    Fuehererscheinklassen,
    Fuehrerscheindatum,
    Geburtsdatum,
    Lieblingsfahrzeug) 
    VALUES(
        '0xF0D89C13A2E57E688AE73AE29821A28197A15725CA8D0C6BB3DA8A012C78D44A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
        'Heinrich.Ansgarsen@Ansgar.de',
        'Heinrich',
        'Ansgarsen',
        'Grünes Eck 1, 23485 Tölbruch',
        'A,B,C',
        TO_DATE('1995-05-10', 'yyyy-mm-dd'),
        TO_DATE('1975-03-12', 'yyyy-mm-dd'),
        'HH - AF 204'
    );
    
INSERT INTO Fahrer (
    Passwort,
    EMailadresse,
    Vorname,
    Nachname,
    Adresse,
    Fuehererscheinklassen,
    Fuehrerscheindatum,
    Geburtsdatum,
    Lieblingsfahrzeug) 
    VALUES(
        '0xF0D89C13A2E57E688AE73AE29821A28197A15725CA8D0C6BB3DA8A012C78D44A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
        'Elisabetha.Ansgarsen@Ansgar.de',
        'Elisabetha',
        'Ansgarsen',
        'Grünes Eck 1, 23485 Tölbruch',
        'B',
        TO_DATE('2005-05-10', 'yyyy-mm-dd'),
        TO_DATE('1980-03-12', 'yyyy-mm-dd'),
        'HH - EF 001'
    );
    
INSERT INTO Fahrer (
    Passwort,
    EMailadresse,
    Vorname,
    Nachname,
    Adresse,
    Fuehererscheinklassen,
    Fuehrerscheindatum,
    Geburtsdatum,
    Lieblingsfahrzeug) 
    VALUES(
        '0x313232313234333537360000000000000000000000123455aa',
        'MaryMueller@gmail.com',
        'Mary',
        'Mueller',
        'Berliner Tor 11, 20099 Hamburg',
        'C',
        TO_DATE('2020-12-01', 'yyyy-mm-dd'),
        TO_DATE('1991-02-11', 'yyyy-mm-dd'),
        'HH - KK 105'
    );
    
INSERT INTO Fahrer (
    Passwort,
    EMailadresse,
    Vorname,
    Nachname,
    Adresse,
    Fuehererscheinklassen,
    Fuehrerscheindatum,
    Geburtsdatum,
    Lieblingsfahrzeug) 
    VALUES(
        '0xF0D89C13A2E573945AE73AE29821A28197A15725CA8D0C6BB3DA8A012C78D44A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
        'xenia_goettindesfeuers@arbeitsamt.hamburg.de',
        'Kerstin',
        'Barben',
        'Im Garten 3, 23256 Ahrensburg',
        'B',
        TO_DATE('1987-05-10', 'yyyy-mm-dd'),
        TO_DATE('1967-03-12', 'yyyy-mm-dd'),
        'HH - AF 204'
    );
    
INSERT INTO Fahrer (
    Passwort,
    EMailadresse,
    Vorname,
    Nachname,
    Adresse,
    Fuehererscheinklassen,
    Fuehrerscheindatum,
    Geburtsdatum,
    Lieblingsfahrzeug) 
    VALUES(
        '0xF0D89C13A2E57E688AE73AE29821A28190000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
        'ninaschultz@haw-hamburg.de',
        'Nina',
        'Schultz',
        'Nehringstrasse 10, 10027 Berlin',
        'A,B',
        TO_DATE('2014-05-05', 'yyyy-mm-dd'),
        TO_DATE('1994-03-11', 'yyyy-mm-dd'),
        'HH - AF 204'
    );    

INSERT INTO Fahrer (
    Passwort,
    EMailadresse,
    Vorname,
    Nachname,
    Adresse,
    Fuehererscheinklassen,
    Fuehrerscheindatum,
    Geburtsdatum,
    Lieblingsfahrzeug) 
    VALUES(
        '0xF0D89C13A2E57E688AE73AE29821A2819000000009876543456789876540000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
        'rosalila@fuckyeah.de',
        'Rosa',
        'Lila',
        'Caffamacherreihe 45, 23547 Hamburg',
        'B',
        TO_DATE('2006-05-05', 'yyyy-mm-dd'),
        TO_DATE('1989-03-11', 'yyyy-mm-dd'),
        NULL
    );    

INSERT INTO Fahrer (
    Passwort,
    EMailadresse,
    Vorname,
    Nachname,
    Adresse,
    Fuehererscheinklassen,
    Fuehrerscheindatum,
    Geburtsdatum,
    Lieblingsfahrzeug) 
    VALUES(
        '0xF0D890000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
        'LauraDirk@arbeitsamt.hamburg.de',
        'Laura',
        'Dirk',
        'Franz-Nehring-Platz 15, 10026 Berlin',
        'B',
        TO_DATE('1997-05-10', 'yyyy-mm-dd'),
        TO_DATE('1977-03-12', 'yyyy-mm-dd'),
        'F234231'
    );    

INSERT INTO Zahlungsmittel(
    Bezeichnung,
    Typ,
    Zahlungsmitteldaten,
    Fahreremail)
    VALUES(
        'Papas Karte',
        'American Express',
        '1234567893216548/168',
        'Heinrich.Ansgarsen@Ansgar.de'
    );

INSERT INTO Zahlungsmittel(
    Bezeichnung,
    Typ,
    Zahlungsmitteldaten,
    Fahreremail)
    VALUES(
        'Papas Karte',
        'American Express' ,
        '1234567893216548/168',
        'Elisabetha.Ansgarsen@Ansgar.de'
    );

INSERT INTO Zahlungsmittel(
    Bezeichnung,
    Typ,
    Zahlungsmitteldaten,
    Fahreremail)
    VALUES(
        'Paypal',
        'Paypal',
        'Elisabetha.Ansgarsen@Ansgar.de',
        'Elisabetha.Ansgarsen@Ansgar.de'
    );

INSERT INTO Zahlungsmittel(
    Bezeichnung,
    Typ,
    Zahlungsmitteldaten,
    Fahreremail)
    VALUES(
        'Muttis Kreditkarte',
        'MasterCard',
        '499870084803428/233',
        'MaxiMauke@gmail.com'
    );

INSERT INTO Zahlungsmittel(
    Bezeichnung,
    Typ,
    Zahlungsmitteldaten,
    Fahreremail)
    VALUES(
        'MeineKarte',
        'N26',
        '1000100010001111/322',
        'LauraDirk@arbeitsamt.hamburg.de'
    );
    
INSERT INTO Zahlungsmittel(
    Bezeichnung,
    Typ,
    Zahlungsmitteldaten,
    Fahreremail)
    VALUES(
        'Firmenkarte',
        'AMEX',
        '2340100023012111/712',
        'xenia_goettindesfeuers@arbeitsamt.hamburg.de'
    );

INSERT INTO Zahlungsmittel(
    Bezeichnung,
    Typ,
    Zahlungsmitteldaten,
    Fahreremail)
    VALUES(
        'Mein eigenes Geld',
        'MasterCard',
        '2345100023012221/352',
        'xenia_goettindesfeuers@arbeitsamt.hamburg.de'
    );

INSERT INTO Miete(
    ID,
    von,
    bis,
    Preis,
    Fahreremail,
    Fahrzeug,
    Zahlungsmittel)
    VALUES(
        SYS_GUID(),
        stempel(TO_DATE('2021-06-05 15:01:03', 'yyyy-mm-dd HH24:MI:SS'), 440, '13.545401, 9.963184'),
        stempel(TO_DATE('2021-06-05 18:23:00', 'yyyy-mm-dd HH24:MI:SS'), 460, '13.545401, 9.945184'),
        23.34,
        'MaxiMauke@gmail.com',
        'F234231',
        'Muttis Kreditkarte'
    );

INSERT INTO Miete(
    ID,
    von,
    bis,
    Preis,
    Fahreremail,
    Fahrzeug,
    Zahlungsmittel)
    VALUES(
        SYS_GUID(),
        stempel(TO_DATE('2021-06-05 07:12:03', 'yyyy-mm-dd HH24:MI:SS'), 800, '53.223422, 9.123544'),
        stempel(TO_DATE('2021-06-05 08:22:00', 'yyyy-mm-dd HH24:MI:SS'), 1012, '53.123422, 9.123444'),
        10.20,
        'MaxiMauke@gmail.com',
        'HH - KK 105',
        'Muttis Kreditkarte'
    );

INSERT INTO Miete(
    ID,
    von,
    bis,
    Preis,
    Fahreremail,
    Fahrzeug,
    Zahlungsmittel)
    VALUES(
        SYS_GUID(),
        stempel(TO_DATE('2021-06-08 07:12:03', 'yyyy-mm-dd HH24:MI:SS'), 42, '10.123422, 19.123544'),
        stempel(TO_DATE('2021-06-08 08:22:00', 'yyyy-mm-dd HH24:MI:SS'), 60, '10.123422, 19.123544'),
        16.50,
        'Elisabetha.Ansgarsen@Ansgar.de',
        'HH - EF 001',
        'Paypal'
    );

INSERT INTO Miete(
    ID,
    von,
    bis,
    Preis,
    Fahreremail,
    Fahrzeug,
    Zahlungsmittel)
    VALUES(
        SYS_GUID(),
        stempel(TO_DATE('2021-06-05 15:01:03', 'yyyy-mm-dd HH24:MI:SS'), 430, '53.545401, 9.963184'),
        stempel(TO_DATE('2021-06-05 18:23:00', 'yyyy-mm-dd HH24:MI:SS'), 450, '53.545401, 9.963184'),
        200,
        'Elisabetha.Ansgarsen@Ansgar.de',
        'HH - KAT 001',
        'Papas Karte'
    );

INSERT INTO Miete(
    ID,
    von,
    bis,
    Preis,
    Fahreremail,
    Fahrzeug,
    Zahlungsmittel)
    VALUES(
        SYS_GUID(),
        stempel(TO_DATE('2021-06-08 01:03:45', 'yyyy-mm-dd HH24:MI:SS'), 150, '53.404809, 9.753545'),
        stempel(TO_DATE('2021-06-08 03:15:01', 'yyyy-mm-dd HH24:MI:SS'), 240, '53.534809, 9.823545'),
        120,
        'Heinrich.Ansgarsen@Ansgar.de',
        'HH - CH 1234',
        'Papas Karte'
    );

INSERT INTO Miete(
    ID,
    von,
    bis,
    Preis,
    Fahreremail,
    Fahrzeug,
    Zahlungsmittel)
    VALUES(
        SYS_GUID(),
        stempel(TO_DATE('2021-05-23 15:15:00', 'yyyy-mm-dd HH24:MI:SS'), 23014, '53.534809, 9.823545'),
        stempel(TO_DATE('2021-05-23 18:20:56', 'yyyy-mm-dd HH24:MI:SS'), 23054, '53.534809, 9.823545'),
        52.12,
        'xenia_goettindesfeuers@arbeitsamt.hamburg.de',
        'HH - AF 203',
        'Firmenkarte'
    );


INSERT INTO Miete(
    ID,
    von,
    bis,
    Preis,
    Fahreremail,
    Fahrzeug,
    Zahlungsmittel)
    VALUES(
        SYS_GUID(),
        stempel(TO_DATE('2021-06-01 14:10:44', 'yyyy-mm-dd HH24:MI:SS'), 150,'53.534809, 9.823545'),
        stempel(TO_DATE('2021-06-01 14:50:30', 'yyyy-mm-dd HH24:MI:SS'), 182,'53.512809, 9.673545'),
        10.50,
        'LauraDirk@arbeitsamt.hamburg.de',
        'HH - CH 1234',
        'MeineKarte'
    );
    
INSERT INTO Miete(
    ID,
    von,
    bis,
    Preis,
    Fahreremail,
    Fahrzeug,
    Zahlungsmittel)
    VALUES(
        SYS_GUID(),
        stempel(TO_DATE('2021-06-04 15:15:45', 'yyyy-mm-dd HH24:MI:SS'), 30046, '53.534809, 9.823545'),
        stempel(TO_DATE('2021-06-04 15:45:12', 'yyyy-mm-dd HH24:MI:SS'), 30054, '53.534809, 9.823545'),
        10.34,
        'xenia_goettindesfeuers@arbeitsamt.hamburg.de',
        'HH - KK 105',
        'Firmenkarte'
    );

INSERT INTO Miete(
    ID,
    von,
    bis,
    Preis,
    Fahreremail,
    Fahrzeug,
    Zahlungsmittel)
    VALUES(
        SYS_GUID(),
        stempel(TO_DATE('2021-06-06 14:45:34', 'yyyy-mm-dd HH24:MI:SS'), 550, '53.534809, 9.823545'),
        stempel(TO_DATE('2021-06-06 15:45:12', 'yyyy-mm-dd HH24:MI:SS'), 598, '53.534809, 9.823545'),
        21.50,
        'xenia_goettindesfeuers@arbeitsamt.hamburg.de',
        'HH - EF 001',
        'Mein eigenes Geld'
    );

INSERT INTO Miete(
    ID,
    von,
    bis,
    Preis,
    Fahreremail,
    Fahrzeug,
    Zahlungsmittel)
    VALUES(
        SYS_GUID(),
        stempel(TO_DATE('2021-05-06 16:12:11', 'yyyy-mm-dd HH24:MI:SS'), 20020, '53.123456, 9.789990'),
        stempel(TO_DATE('2021-05-06 17:13:12', 'yyyy-mm-dd HH24:MI:SS'), 20022, '53.534809, 9.823545'),
        20.34,
        'MaxiMauke@gmail.com',
        'HH - KK 106',
        'Muttis Kreditkarte'
    );

-- - Ändern Sie den Nachnamen eines Kunden ab.
-- - Erhöhen Sie den Preis einer Vermietung.
-- - Rechnen Sie alle Preise von EUR auf USD zum aktuellen Kurs um. 
-- - Löschen Sie alle Kunden, die noch nie etwas gemietet haben.
-- - Löschen Sie alle Kunden.  
-- - Fügen Sie die ursprünglichen Kunden wieder in die Datenbank ein.
SAVEPOINT db_new;
COMMIT;

UPDATE Fahrer
SET Nachname = 'Grünwald'
WHERE EMailadresse = 'Elisabetha.Ansgarsen@Ansgar.de';
COMMIT;

UPDATE Fahrzeugtyp
SET Minutenpreis = 0.8
WHERE Hersteller = 'Crafting Hovers'
AND Modell = 'HC2T'
AND Bezeichnung = 'Lasten';
COMMIT;

UPDATE Miete 
SET Preis = Preis*1.22;
COMMIT;

DELETE Fahrer 
WHERE EMailadresse not in (SELECT distinct(Fahreremail) from Miete);
COMMIT;

SET TRANSACTION NAME 'alle_kunden_loeschen';
DELETE Miete;
DELETE Zahlungsmittel;
DELETE Fahrer;
SELECT * from FAHRER;
ROLLBACK;-- TO SAVEPOINT before_delete;
SELECT * from FAHRER;

SELECT ID as Miete, Fahreremail as Fahrer, Name as Fahrzeug from Miete, Fahrer, FAHRZEUG
WHERE (von).Zeitstempel between date'2021-06-07' AND date'2021-06-09'
AND Fahrzeug = Kennzeichen
AND Fahreremail = EMailadresse

