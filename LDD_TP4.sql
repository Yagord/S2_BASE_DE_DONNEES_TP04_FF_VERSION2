 DROP TABLE CLIENT CASCADE CONSTRAINTS;
DROP TABLE ACHAT CASCADE CONSTRAINTS;
DROP TABLE SOCIETE CASCADE CONSTRAINTS;
DROP TABLE ARTICLE CASCADE CONSTRAINTS;

CREATE TABLE CLIENT
   (
    NumClient NUMBER(4)  NOT NULL,
    NomClient VARCHAR2(20)  NOT NULL,
    VilleClient VARCHAR2(20),
    CONSTRAINT PK_CLIENT PRIMARY KEY (NumClient)  
   ) ;

CREATE TABLE SOCIETE
   (
    NumSociete NUMBER(4)  NOT NULL,
    NomSociete VARCHAR2(20)  NOT NULL,
    VilleSociete VARCHAR2(20),
    CONSTRAINT PK_SOCIETE PRIMARY KEY (NumSociete)  
   ) ;

CREATE TABLE ARTICLE
   (
    NumArticle NUMBER(4)  NOT NULL,
    NomArticle VARCHAR2(40)  NOT NULL,
    PrixGrossiste NUMBER(4) NOT NULL,
    CONSTRAINT PK_ARTICLE PRIMARY KEY (NumArticle)  
   ) ;

CREATE TABLE ACHAT
   (
    NumClient NUMBER(4) NOT NULL,
    NumArticle NUMBER(4) NOT NULL,
    NumSociete NUMBER(4) NOT NULL,
    NbArticles NUMBER(4) NOT NULL,
    DateAchat DATE,
    PrixAchat NUMBER(4) NOT NULL,
    CONSTRAINT PK_ACHAT PRIMARY KEY (NumClient, NumArticle, NumSociete, DateAchat),
    CONSTRAINT FK_ACHAT_CLIENT FOREIGN KEY (NumClient)  REFERENCES CLIENT (NumClient),
    CONSTRAINT FK_ACHAT_ARTICLE  FOREIGN KEY (NumArticle)  REFERENCES ARTICLE (NumArticle),    
    CONSTRAINT FK_ACHAT_SOCIETE  FOREIGN KEY (NumSociete)  REFERENCES SOCIETE (NumSociete)   
   ) ;

   
insert into CLIENT values(123, 'PERK', 'Dijon');
insert into CLIENT values(234, 'CANTAT', 'Nice');
insert into CLIENT values(345, 'MIOSSEC',  'Lyon');
insert into CLIENT values(456, 'DE LA SIMONE', 'Paris');
insert into CLIENT values(567, 'CLARK', 'Dijon');
insert into CLIENT values(678, 'STARK',  'Dijon');
insert into CLIENT values(789, 'YODA',  'Toulouse');
insert into CLIENT values(890, 'CRUISE',  'Lyon');
insert into CLIENT values(901, 'ODONNEL', 'Dijon');
insert into CLIENT values(012, 'TARENTINO',  'Paris');
   
insert into SOCIETE values(123, 'Quart Four', 'Toulouse');
insert into SOCIETE values(234, 'Le Clair', 'Nice');
insert into SOCIETE values(345, 'Haut Champ', 'Toulouse');


insert into ARTICLE values(1, 'chaussures', 10);
insert into ARTICLE values(2, 'marteau', 2);
insert into ARTICLE values(3, 'chemise',  12);
insert into ARTICLE values(4, 'casserole', 5);
insert into ARTICLE values(5, 'voiture', 3000);
insert into ARTICLE values(6, 'chaussettes',  1);
insert into ARTICLE values(7, 'tongs',  4);
insert into ARTICLE values(8, 'baignoire',  275);
insert into ARTICLE values(9, 'peigne', 1);
insert into ARTICLE values(10, 'stylo',  2);  
insert into ARTICLE values(11, 'cahier', 1);
insert into ARTICLE values(12, 'kilt', 210);
insert into ARTICLE values(13, 'cure-dents', 1);
insert into ARTICLE values(14, 'CD de Lara Fabian (Limited Edition)', 2150);


insert into ACHAT values(678,1,123,1,TO_DATE('18/03/2015 08:00','DD/MM/YYYY HH24:MI'),15);
insert into ACHAT values(890,2,234,1, TO_DATE('18/03/2015 18:00','DD/MM/YYYY HH24:MI'),4);
insert into ACHAT values(123,2,345,2, TO_DATE('18/03/2015 14:00','DD/MM/YYYY HH24:MI'),5);
insert into ACHAT values(345,3,234,5, TO_DATE('18/03/2015 18:00','DD/MM/YYYY HH24:MI'),45);
insert into ACHAT values(123,4,345,10, TO_DATE('18/03/2015 11:00','DD/MM/YYYY HH24:MI'),17);
insert into ACHAT values(234,5,234,10,  TO_DATE('18/03/2015 11:00','DD/MM/YYYY HH24:MI'),5600);
insert into ACHAT values(456,6,123,10,  TO_DATE('18/03/2015 08:00','DD/MM/YYYY HH24:MI'),2);
insert into ACHAT values(456,8,345,1,  TO_DATE('18/03/2015 07:00','DD/MM/YYYY HH24:MI'),499);
insert into ACHAT values(890,7,123,1, TO_DATE('18/03/2015 09:00','DD/MM/YYYY HH24:MI'),14);
insert into ACHAT values(234,9,123,2,  TO_DATE('18/03/2015 12:00','DD/MM/YYYY HH24:MI'),1);
insert into ACHAT values(234,5,345,2,  TO_DATE('18/03/2015 15:00','DD/MM/YYYY HH24:MI'),6200);
insert into ACHAT values(234,11,123,2,  TO_DATE('18/03/2015 16:00','DD/MM/YYYY HH24:MI'),2);
insert into ACHAT values(567,12,234,3,  TO_DATE('18/03/2015 11:00','DD/MM/YYYY HH24:MI'),250);
insert into ACHAT values(567,13,123,4,  TO_DATE('18/03/2015 15:00','DD/MM/YYYY HH24:MI'),2500);
insert into ACHAT values(567,11,345,5,  TO_DATE('18/03/2015 17:00','DD/MM/YYYY HH24:MI'),2500);
insert into ACHAT values(567,3,234,5,  TO_DATE('18/03/2015 18:00','DD/MM/YYYY HH24:MI'),40);
insert into ACHAT values(890,2,234,6, TO_DATE('18/03/2015 21:00','DD/MM/YYYY HH24:MI'),4);
insert into ACHAT values(789,1,123,1, TO_DATE('18/03/2015 11:00','DD/MM/YYYY HH24:MI'),17);

/*Partie 1*/
/*1*/
UPDATE Client
SET nomClient = 'DETROIT'
WHERE nomClient = 'CANTAT';
/

/*2*/
SELECT Article.nomArticle, Article.numArticle
FROM Article
WHERE numArticle NOT IN(SELECT Achat.numArticle
                        FROM Achat);
/

/*3*/
SET SERVEROUTPUT ON
DECLARE
  l_chiffreAffaire NUMBER := 0;
BEGIN
  FOR l_societe IN (SELECT numSociete, nomSociete
                    FROM Societe) LOOP
    FOR l_ca IN (SELECT Achat.nbArticles, Achat.prixAchat, Article.prixGrossiste
                  FROM Achat INNER JOIN Article ON (Achat.numArticle = Article.numArticle)
                  WHERE Achat.numSociete = l_societe.numSociete) LOOP
        l_chiffreAffaire := l_chiffreAffaire + (l_ca.nbArticles * (l_ca.prixAchat - l_ca.prixGrossiste));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('- ' || l_societe.nomSociete || ' a fait un CA de ' || l_chiffreAffaire || ' €');
    l_chiffreAffaire := 0;
  END LOOP;
END;
/

/*4*/
SET SERVEROUTPUT ON
DECLARE
  l_numClient Client.numClient%TYPE := &ask;
  l_nombreAchat NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO l_nombreAchat
  FROM Achat INNER JOIN Client ON (Achat.numClient = Client.numClient)
  WHERE Achat.numClient = l_numClient;
  
  DBMS_OUTPUT.PUT_LINE(l_numClient || ' a acheté ' || l_nombreAchat || ' produits.');
END;
/

DECLARE
  l_client Client%ROWTYPE;
  l_nbAchat NUMBER;
BEGIN
  l_client.numClient := &ask;
  SELECT COUNT(*)
  INTO l_nbAchat
  FROM Achat INNER JOIN Client ON (Achat.numClient = Client.numClient)
  WHERE Achat.numClient = l_client.numClient;
  
  SELECT nomClient
  INTO l_client.nomClient
  FROM Client
  WHERE numClient = l_client.numClient;
  
  DBMS_OUTPUT.PUT_LINE(l_client.nomClient || ' a acheté ' || l_nbAchat || ' produits.');
END;
/

DECLARE
  l_numClient Client.numClient%TYPE := &ask;
BEGIN
  FOR l_client IN (SELECT Client.nomClient, COUNT(*) AS nbAchat
                    FROM Client
                    WHERE Client.numClient = l_numClient
                    GROUP BY Client.nomClient) LOOP
    DBMS_OUTPUT.PUT_LINE(l_client.nomClient || ' a acheté ' || l_client.nbAchat || ' produits.');
  END LOOP;
END;
/

/*5*/
SET SERVEROUTPUT ON
DECLARE
  l_nomClient Client.nomClient%TYPE := '&ask';
  l_nombreAchat NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO l_nombreAchat
  FROM Achat INNER JOIN Client ON (Achat.numClient = Client.numClient)
  WHERE UPPER(Client.nomClient) = UPPER(l_nomClient);
  
  DBMS_OUTPUT.PUT_LINE(l_nomClient || ' a acheté ' || l_nombreAchat || ' produits.');
END;
/

/*6*/
SET SERVEROUTPUT ON
BEGIN
  FOR l_client IN (SELECT Client.numClient, Client.nomClient
                    FROM Client) LOOP
    DBMS_OUTPUT.PUT_LINE('Liste des achats de ' || l_client.nomClient);
    FOR l_societe IN (SELECT DISTINCT Achat.numSociete, Societe.nomSociete
                      FROM Achat INNER JOIN Societe ON (Achat.numSociete = Societe.numSociete)
                      WHERE Achat.numClient = l_client.numClient) LOOP
      DBMS_OUTPUT.PUT('     - à ' || l_societe.nomSociete || ' : ');
      FOR l_article IN (SELECT Achat.numArticle, Article.nomArticle
                        FROM Achat INNER JOIN Article ON (Achat.numArticle = Article.numArticle) INNER JOIN Societe ON (Achat.numSociete = Societe.numSociete)
                        WHERE ((Achat.numClient = l_client.numClient) AND (Achat.numSociete = l_societe.numSociete))
                        ORDER BY Article.nomArticle) LOOP
        DBMS_OUTPUT.PUT(l_article.nomArticle || ', ');
      END LOOP;
          DBMS_OUTPUT.NEW_LINE();
    END LOOP;
  END LOOP;
END;
/