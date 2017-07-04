# DB Namenskonventionen

## Zweck


## Übersetzungen


## Inhaltsverzeichnis



  1. [Sprache](#sprache)
  1. [Projektpräfix](#projektpräfix)
  1. [Tabellenkürzel](#tabellenkürzel)
  1. [Spaltenkürzel](#spaltenkürzel)
  1. [Generelle Namenskonventionen](#generelle-namenskonventionen)
  1. [Tabellen](#tabellen)
  1. [Views](#views)
  1. [Trigger](#trigger)
  1. [Sequenzen](#sequenzen)
  1. [Spalten](#spalten)
  1. [Constraints](#constraints)
  1. [Indizes](#indizes)
  1. [Nicht aufgeführte Objekt-Typen](#nicht-aufgeführte-objekt-typen)
## Sprache
###### [Regel [R001](#regel-r001)]

Als Sprache für die Benennung der Schema-Objekte ist Englisch zu wählen.

Die Sprache für Quelltext- und Dokumentationskommentare kann unabhängig gewählt werden.

**[Zurück nach oben](#inhaltsverzeichnis)**
## Projektpräfix
###### [Regel [R002](#regel-r002)]

Es _kann_ ein Projektpräfix vereinbart werden.
Diese Präfixe werden, gefolgt von einem Unterstrich '_', jedem Tabellen- oder Viewnamen vorangestellt.
Ein Präfix besteht aus maximal 3 alphanumerischen Zeichen, beginnend mit einem Buchstaben.

_Warum?_ Projektpräfixe sind sinnvoll, um die Verwendung von Tabellen oder Views im Applikationsquelltext identifizieren zu können, insbesondere bei Nutzung von
eingebettetem SQL oder im Quelltext verteilten SQL (JDBC). Alternativ kann mitunter konsequent das Schema verwendet werden.


**[Zurück nach oben](#inhaltsverzeichnis)**
## Tabellenkürzel
###### [Regel [R003](#regel-r003)]

Für jede Tabelle _muss_ ein eindeutiges Tabellenkürzel vereinbart werden.
Alle Tabellenkürzel und Tabellennamen sind innerhalb ihres Schemas eindeutig.
Ein Tabellenkürzel besteht aus bis zu 5 alphanumerischen Zeichen, beginnend mit einem Buchstaben.
Dieses Tabellenkürzel _muss_ in den Kommentar zur Tabelle wie folgt aufgenommen werden.

  ```sql
  comment on table employee is 'abbrev=emp; ...';
  ```

_Warum?_ Dies ermöglicht unter Anderem die automatische Zuordnung einer Sequenz zu einer Tabelle.


**[Zurück nach oben](#inhaltsverzeichnis)**
## Spaltenkürzel
###### [Regel [R004](#regel-r004)]


Für jede Spalte _kann_ ein eindeutiges Spaltenkürzel vereinbart werden.
Ein Spaltekürzel besteht aus bis zu 6 alphanumerischen Zeichen, beginnend mit einem Buchstaben.
Dieses Spaltenkürzel _kann_ in den Kommentar zur Spalte wie folgt aufgenommen werden.

  ```sql
  comment on column employee.last_name is 'abbrev=empnam; ...';
  ```


**[Zurück nach oben](#inhaltsverzeichnis)**
## Generelle Namenskonventionen
###### [Regel [R005](#regel-r005)]

Alle Namen bestehen nur aus den Buchstaben 'A'-'Z', den Zahlen '0'-'9', sowie dem Unterstrich '_'.
Alle Namen beginnen mit einem Buchstaben.
Alle Namen sind höchstens 30 Zeichen lang.
Objecte sind immer case-insensitiv anzulegen.
Namen entsprechen nicht den reservierten Wörtern oder Schlüsselwörtern.

**[Zurück nach oben](#inhaltsverzeichnis)**
## Tabellen
###### [Regel [R006](#regel-r006)]

| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| Tabellen | \<FachlicherName\> | employee |
| Journal-Tabellen | \<FachlicherName\>_JN | employee_jn,<br />_Es existiert ebenso die Tabelle <FachlicherName> als Grundlage der Journals._ |
| Logging-Tabellen | \<FachlicherName\>_LOG | import_log |
| DML-Error-Logging-Tabellen | \<FachlicherName\>_ERR| debitor_err,<br />_Es existiert ebenso die Tabelle <FachlicherName> als Grundlage betreffender DML-Statements._ |


**[Zurück nach oben](#inhaltsverzeichnis)**
## Views
###### [Regel [R007](#regel-r007)]

| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| View | \<FachlicherName\>_V | employee_v,<br />_\<FachlicherName\> darf ebenso ein Tabellenname sein, muss aber nicht._ |


**[Zurück nach oben](#inhaltsverzeichnis)**
## Trigger
###### [Regel [R008](#regel-r008)]

| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| Sequenz-Trigger | \<TabellenKürzel\>_SEQ_TG | emp_seq_tg |
| Journalling-Trigger | \<TabellenKürzel\>_JN_TG | emp_jn_tg |
| Auditing-Trigger | \<TabellenKürzel\>_AUD_TG | emp_aud_tg |


**[Zurück nach oben](#inhaltsverzeichnis)**
## Sequenzen

Dieser Abschnitt gilt für Sequenzen, die zur Befüllung der technischen Schlüsselspalte dienen.
Weitere Sequenzen sind prinzipiell erlaubt, aufgrund ihrer Seltenheit hier jedoch nicht erfasst.

###### [Regel [R009](#regel-r009)]

| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| Sequenz | <TabellenKürzel>_SEQ | emp_seq,<br />_Für Spalte id der Tabelle mit dem betreffenden \<TabellenKürzel\>._ |

**[Zurück nach oben](#inhaltsverzeichnis)**
###### [Regel [R010](#regel-r010)]

Sequenzen starten immer bei 1.

**[Zurück nach oben](#inhaltsverzeichnis)**
###### [Regel [R011](#regel-r011)]

Tabellen, die über bulk-inserts befüllt werden, dürfen cachende Sequenzen verwenden.


**[Zurück nach oben](#inhaltsverzeichnis)**
###### [Regel [R012](#regel-r012)]

Beispiel:

  ```sql
  create sequence emp_seq nocycle nocache maxvalue 999999999999999999 minvalue 0 start with 1;
  ```



**[Zurück nach oben](#inhaltsverzeichnis)**
## Spalten
###### [Regel [R013](#regel-r013)]

| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| Technische Schlüsselspalte | id | employee.id |
| Fremdschlüsselspalte | \<TabellenKürzel\>_id,<br />\<TabellenKürzel\>_\<Qualifikation\>_id | employee.dep_id<br />_\<TabellenKürzel\> der referenzierten Tabelle<br />\<Qualifikation\> bei mehreren Referenzen._ |
| Auditing-Spalte,<br />Erstellungsdatum | created_date | employee.created_date |
| Auditing-Spalte,<br />Änderungsdatum | modified_date | employee.modified_date |
| Weitere Spalten | nicht 'id', enden nicht auf '_id', keine Auditing-Spalte | employee.last_name |


**[Zurück nach oben](#inhaltsverzeichnis)**
## Constraints
###### [Regel [R014](#regel-r014)]

| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| Primary Key Constraint | \<TabellenKürzel\>_PK | emp_pk|
| Unique Constraint | \<TabellenKürzel\>_\<Qualifikation\>_UK | emp_username_uk |
| Foreign Key Constraint | \<TabellenKürzel\>_\<TabellenKürzel\>_FK,<br />\<TabellenKürzel\>_\<TabellenKürzel\>_\<Qualifikation\>_FK| emp_dep_fk |
| Check Constraint | <TabellenKürzel>_<Qualifikation>_CK | emp_manager_ck |
| Not Null Constraint | - (kein Name notwendig) | |

**[Zurück nach oben](#inhaltsverzeichnis)**
## Indizes
###### [Regel [R015](#regel-r015)]

| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| Index | \<TabellenKürzel\>_\<Qualifikation\>_IX | emp_id_ix |




**[Zurück nach oben](#inhaltsverzeichnis)**
## Nicht aufgeführte Objekt-Typen

### Synonyme

Synonyme sind im einem Applikationsschema verboten.
Synonyme sind nur in einem Schema erlaubt, über die ein Fremdsystem auf ein Applikationsschema zugreift.
Nachteil: Müssen in diesem Fremdschema gepflegt werden, je nach Betriebskonzept bedeutet dies möglicherweise eine weitere Auslieferung.


**[Zurück nach oben](#inhaltsverzeichnis)**
### Öffentliche Synonyme

Öffentliche Synonyme sind verboten.

**[Zurück nach oben](#inhaltsverzeichnis)**
### DBMS Jobs/Scheduler Jobs

DBMS Jobs sind verboten.
Es sind Scheduler Jobs zu verwenden.
Diese sind noch nicht Teil dieses Dokumentes.
Es sind nur Scheduler Jobs mit dem Job-Typ "STORED_PROCEDURE" erlaubt.

_Warum?_ für eine stored procedure ist sichergestellt, dass diese kompiliert. Das gilt nicht für Anonyme PL/SQL-Blöcke.


**[Zurück nach oben](#inhaltsverzeichnis)**
### Advanced Queueing

Erlaubt, aber noch nicht Teil dieses Dokumentes.

**[Zurück nach oben](#inhaltsverzeichnis)**
### Functions, Procedures, Packages und Package Bodies

Erlaubt, aber noch nicht Teil dieses Dokumentes.
Functions und Procedures _sollten_ bevorzugt in Packages abgelegt werden.

