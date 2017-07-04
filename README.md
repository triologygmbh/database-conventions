# DB Namenskonventionen

## Zweck



## Übersetzungen


## Inhaltsverzeichnis



  1. [Sprache](#topic1)
  1. [Projektpräfix](#topic2)
  1. [Tabellenkürzel](#topic3)
  1. [Spaltenkürzel](#topic4)
  1. [Namenskonventionen](#topic5)
## Sprache
###### [Regel [R001](#rule-r001)]

Als Sprache für die Benennung der Schema-Objekte ist Englisch zu wählen.

Die Sprache für Quelltext- und Dokumentationskommentare kann unabhängig gewählt werden.

**[Zurück nach oben](#table-of-contents)**
## Projektpräfix
###### [Regel [R002](#rule-r002)]

Es _kann_ ein Projektpräfix vereinbart werden.
Diese Präfixe werden, gefolgt von einem Unterstrich '_', jedem Tabellen- oder Viewnamen vorangestellt.
Ein Präfix besteht aus maximal 3 alphanumerischen Zeichen, beginnend mit einem Buchstaben.

_Warum?_ Projektpräfixe sind sinnvoll, um die Verwendung von Tabellen oder Views im Applikationsquelltext identifizieren zu können, insbesondere bei Nutzung von
eingebettetem SQL oder im Quelltext verteilten SQL (JDBC). Alternativ kann mitunter konsequent das Schema verwendet werden.


**[Zurück nach oben](#table-of-contents)**
## Tabellenkürzel
###### [Regel [R003](#rule-r003)]

Für jede Tabelle _muss_ ein eindeutiges Tabellenkürzel vereinbart werden.
Alle Tabellenkürzel und Tabellennamen sind innerhalb ihres Schemas eindeutig.
Ein Tabellenkürzel besteht aus bis zu 5 alphanumerischen Zeichen, beginnend mit einem Buchstaben.
Dieses Tabellenkürzel _muss_ in den Kommentar zur Tabelle wie folgt aufgenommen werden.

  ```sql
  comment on table employee is 'abbrev=emp; ...';
  ```

_Warum?_ Dies ermöglicht unter Anderem die automatische Zuordnung einer Sequenz zu einer Tabelle.


**[Zurück nach oben](#table-of-contents)**
## Spaltenkürzel
###### [Regel [R004](#rule-r004)]


Für jede Spalte _kann_ ein eindeutiges Spaltenkürzel vereinbart werden.
Ein Spaltekürzel besteht aus bis zu 6 alphanumerischen Zeichen, beginnend mit einem Buchstaben.
Dieses Spaltenkürzel _kann_ in den Kommentar zur Spalte wie folgt aufgenommen werden.

  ```sql
  comment on column employee.last_name is 'abbrev=empnam; ...';
  ```


**[Zurück nach oben](#table-of-contents)**
## Namenskonventionen

### Tabellen
###### [Regel [R005](#rule-r005)]

**[Zurück nach oben](#table-of-contents)**
### Views
###### [Regel [R006](#rule-r006)]

**[Zurück nach oben](#table-of-contents)**
### Trigger
###### [Regel [R007](#rule-r007)]

**[Zurück nach oben](#table-of-contents)**
### Sequenzen
###### [Regel [R008](#rule-r008)]

**[Zurück nach oben](#table-of-contents)**
### Spalten
###### [Regel [R009](#rule-r009)]

**[Zurück nach oben](#table-of-contents)**
### Constraints
###### [Regel [R010](#rule-r010)]

**[Zurück nach oben](#table-of-contents)**
### Indizes
###### [Regel [R011](#rule-r011)]




