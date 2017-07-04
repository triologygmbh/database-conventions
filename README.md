# DB Namenskonventionen

## Zweck



## Übersetzungen


## Inhaltsverzeichnis



  1. [Sprache](#sprache)
  1. [Projektpräfix](#projektpräfix)
  1. [Tabellenkürzel](#tabellenkürzel)
  1. [Spaltenkürzel](#spaltenkürzel)
  1. [Namenskonventionen](#namenskonventionen)
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
## Namenskonventionen

### Tabellen
###### [Regel [R005](#regel-r005)]

- Normale Tabellen

| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| Tabellen | <FachlicherName> | employee |
| Journal-Tabellen | <FachlicherName>_JN | employee_jn, __Es existiert ebenso die Tabelle <FachlicherName> als Grundlage der Journals.__ |
| Logging-Tabellen | <FachlicherName>_LOG | import_log |
| DML-Error-Logging-Tabellen | <FachlicherName>_ERR| debitor_err, __Es existiert ebenso die Tabelle <FachlicherName> als Grundlage betreffender DML-Statements.__ |










**[Zurück nach oben](#inhaltsverzeichnis)**
### Views
###### [Regel [R006](#regel-r006)]

**[Zurück nach oben](#inhaltsverzeichnis)**
### Trigger
###### [Regel [R007](#regel-r007)]

**[Zurück nach oben](#inhaltsverzeichnis)**
### Sequenzen
###### [Regel [R008](#regel-r008)]

**[Zurück nach oben](#inhaltsverzeichnis)**
### Spalten
###### [Regel [R009](#regel-r009)]

**[Zurück nach oben](#inhaltsverzeichnis)**
### Constraints
###### [Regel [R010](#regel-r010)]

**[Zurück nach oben](#inhaltsverzeichnis)**
### Indizes
###### [Regel [R011](#regel-r011)]




