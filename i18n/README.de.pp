~ -- include functions
~ dofile ("src/functions")

~ -- set language
~ language = "de";


# Design- und Namenskonventionen für Datenbanken


## Inhaltsverzeichnis

~ -- deferred inclusion of toc for second pass...
~ io.write("~ incl('toc.tmp')")

~ topic ("Sprache")
~ rule()

Als Sprache für die Benennung der Schema-Objekte ist Englisch zu wählen.

Die Sprache für Quelltext- und Dokumentationskommentare kann unabhängig gewählt werden.

~ topic ("Projektpräfix")

~ rule()
Es _kann_ ein Projektpräfix vereinbart werden.
Diese Präfixe werden, gefolgt von einem Unterstrich '_', jedem Tabellen- oder Viewnamen vorangestellt.
Ein Präfix besteht aus maximal 3 alphanumerischen Zeichen, beginnend mit einem Buchstaben.

_Warum?_ Projektpräfixe sind sinnvoll, um die Verwendung von Tabellen oder Views im Applikationsquelltext identifizieren zu können, insbesondere bei Nutzung von
eingebettetem SQL oder im Quelltext verteilten SQL (JDBC). Alternativ kann mitunter konsequent das Schema verwendet werden.


~ topic ("Tabellenkürzel")

~ rule()
Für jede Tabelle _muss_ ein eindeutiges Tabellenkürzel vereinbart werden.
Alle Tabellenkürzel und Tabellennamen sind innerhalb ihres Schemas eindeutig.
Ein Tabellenkürzel besteht aus bis zu 5 alphanumerischen Zeichen, beginnend mit einem Buchstaben.
Dieses Tabellenkürzel _muss_ in den Kommentar zur Tabelle wie folgt aufgenommen werden.

  ```sql
  comment on table employee is 'abbrev=emp; ...';
  ```

Alternativ:

  ```sql
  comment on table employee is '...; abbrev=emp';
  ```


_Warum?_ Dies ermöglicht unter Anderem die automatische Zuordnung einer Sequenz zu einer Tabelle.


~ topic ("Spaltenkürzel")
~ rule()


Für jede Spalte _kann_ ein eindeutiges Spaltenkürzel vereinbart werden.
Ein Spaltenkürzel besteht aus bis zu 6 alphanumerischen Zeichen, beginnend mit einem Buchstaben.
Dieses Spaltenkürzel _kann_ in den Kommentar zur Spalte wie folgt aufgenommen werden.

  ```sql
  comment on column employee.last_name is 'abbrev=empnam; ...';
  ```

Alternativ:

  ```sql
  comment on column employee.last_name is '...; abbrev=empnam';
  ```

~ topic("Generelle Namenskonventionen")
~ rule()

Alle Namen bestehen nur aus den Buchstaben 'A'-'Z', den Zahlen '0'-'9', sowie dem Unterstrich '_'.
Alle Namen beginnen mit einem Buchstaben.
Alle Namen sind höchstens 30 Zeichen lang.
Objekte sind immer case-insensitiv anzulegen.
Namen entsprechen nicht den reservierten Wörtern oder Schlüsselwörtern.

~ topic("Tabellen")
~ rule()

| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| Tabellen | \<FachlicherName\> | employee |
| Journal-Tabellen | \<FachlicherName\>_JN | employee_jn,<br />_Es existiert ebenso die Tabelle \<FachlicherName\> als Grundlage der Journals._ |
| Logging-Tabellen | \<FachlicherName\>_LOG | import_log |
| DML-Error-Logging-Tabellen | \<FachlicherName\>_ERR| debitor_err,<br />_Es existiert ebenso die Tabelle \<FachlicherName\> als Grundlage betreffender DML-Statements._ |
| Backups/Kopien | \<FachlicherName\>_BAK| debitor_bak,<br />_Es existiert ebenso die Tabelle \<FachlicherName\> als Ursprung der Kopie._ |

~ topic("Views")

~ rule()
| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| View | \<FachlicherName\>_V | employee_v,<br />_\<FachlicherName\> darf ebenso ein Tabellenname sein, muss aber nicht._ |


~ rule()
Views werden nicht geschachtelt.

_Warum?_ ineinander geschachtelte Views führen früher oder später zu Performance-Problemen.

~ rule()
Views sind als Teil einer Applikationszugriffsschicht verboten.

~ rule()
Views sind erlaubt:
- als Hilfsmittel/Komfort für Entwickler oder DBA.
- zum Verbergen von Komplexität (Denormalisierung) vor Fremdsystemen.
- zum Verbergen von Informationen in Zeilen oder Spalten (Information Hiding) vor Fremdsystemen.

~ topic("Trigger")

~ rule()
Es gibt 3 verschiedene Arten von Triggern, die verwendet werden dürfen.
- Sequenz-Trigger dienen der Befüllung der technischen Schlüsselspalte id (before row insert).
- Auditing-Trigger dienen der Befüllung der Auditing-Spalten (before row insert/update).
- Journalling-Trigger dienen der Befüllung von Journal-Tabellen (after row insert/update/delete).

~ rule()
| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| Sequenz-Trigger | \<TabellenKürzel\>_SEQ_TG | emp_seq_tg |
| Journalling-Trigger | \<TabellenKürzel\>_JN_TG | emp_jn_tg |
| Auditing-Trigger | \<TabellenKürzel\>_AUD_TG | emp_aud_tg |

~ rule()
Die Erstellung weiterer Trigger ist verboten.

~ rule()
Als Alternative zu Triggern ist eine geeignete Zugriffsschicht zu implementieren.

~ rule()
Alles-oder-Nichts-Prinzip:

- Wenn es eine technische Schlüsselspalte gibt, die aus einem Sequenz-Trigger befüllt wird, dann gilt dies für alle technischen Schlüsselspalten.
- Wenn es einen Auditing-Trigger gibt, der Auditing-Spalten befüllt, so werden alle Auditing-Spalten über einen Auditing-Trigger befüllt.
- Wenn es eine Journal-Tabelle gibt, die über einen Journalling-Trigger befüllt wird, dann gilt dies für alle Journal-Tabellen.

~ rule ()
Sämtliche Trigger sind automatisiert, z.B. aus einem Template, zu erstellen.


~ topic("Sequenzen")

Dieser Abschnitt gilt für Sequenzen, die zur Befüllung der technischen Schlüsselspalte dienen.
Weitere Sequenzen sind prinzipiell erlaubt, aufgrund ihrer Seltenheit hier jedoch nicht erfasst.

~ rule()

| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| Sequenz | <TabellenKürzel>_SEQ | emp_seq,<br />_Für Spalte id der Tabelle mit dem betreffenden \<TabellenKürzel\>._ |

~ rule()

Sequenzen starten immer bei 1.

~ rule()

Tabellen, die über bulk-inserts befüllt werden, dürfen cachende Sequenzen verwenden.


~ rule()

Beispiel einer nicht-cachenden Sequenz für die Befüllung der Spalte _id_ der Tabelle mit dem Kürzel _emp_:

  ```sql
  create sequence emp_seq nocycle nocache maxvalue 999999999999999999 minvalue 0 start with 1;
  ```



~ topic("Spalten")

~ rule()

| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| Technische Schlüsselspalte | ID | employee.id |
| Fremdschlüsselspalte | \<TabellenKürzel\>\_ID,<br />\<TabellenKürzel\>\_\<Qualifikation\>\_ID | employee.dep_id<br />_\<TabellenKürzel\> der referenzierten Tabelle<br />\<Qualifikation\> bei mehreren Referenzen._ |
| Auditing-Spalte,<br />Erstellungsdatum | CREATED_DATE | employee.created_date |
| Auditing-Spalte,<br />Änderungsdatum | MODIFIED_DATE | employee.modified_date |
| Weitere Spalten | nicht 'ID', enden nicht auf '_ID', keine Auditing-Spalte | employee.last_name |

~ subtopic ("Technischer Schlüssel")
~ rule()
Jede Tabelle verfügt über einen technischen Primärschlüssel.
Die Tabelle wird ausschliesslich über diesen Primärschlüssel referenziert.

_Warum?_ Fachliche Schlüssel, die sich durchaus ändern können, sind von der Aufgabe der referentiellen Integrität entkoppelt.

~ rule()
Die technische Schlüsselspalte heisst immer id.
Joins sind somit immer über die id-Spalte aufzubauen, nicht über fachliche Schlüssel, die sich ändern können.

~ rule()
Die technische Schlüsselspalte ist nicht nullable.

_Warum?_ Datensätze sind so immer referenzierbar.

~ rule()
Die technische Schlüsselspalte ist vom Typ NUMBER(18,0)

  ```
  999.999.999.999.999.999 bedeutet:
  999.999 Tage jeweils 999 Milliarden Einträge erstellt.
  999.999 Tage entsprechen ca. 2738 Jahren
  ```

_Warum?_ Damit passt die id bequem in gängige Datentypen, 64bit signed integer (Java: long, C: int64_t/signed long long).

~ rule()
Die technische Schlüsselspalte wird immer von einer Sequenz befüllt.
Dies passiert bevorzugt in einer Zugriffsschicht.


~ subtopic ("Auditing-Spalten")
~ rule()
Auditing-Spalten sind für alle Tabellen verbindlich und ebenso verbindlich zu pflegen.
Dies passiert bevorzugt in einer Zugriffsschicht.

~ rule()
Auditing-Spalten sind nicht nullable, d.h. die Erstanlage zählt als Modifikation.

~ rule()
Auditing-Spalten sind i.d.R. vom Typ Date.




~ topic("Constraints")
~ rule()

| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| Primary Key Constraint | \<TabellenKürzel\>\_PK | emp_pk |
| Unique Constraint | \<TabellenKürzel\>\_\<Qualifikation\>\_UK | emp_username_uk,<br />_Bsp. für \<Qualifikation\>: Spaltenname, Spaltenkürzel (ggf. mehrere), fachlicher Aspekt._ |
| Foreign Key Constraint | \<TabellenKürzel\>\_\<TabellenKürzel\>\_FK,<br />\<TabellenKürzel\>\_\<TabellenKürzel\>\_\<Qualifikation\>\_FK| emp_dep_fk,<br />_Bsp. für \<Qualifikation\>: Spaltenname, Spaltenkürzel (ggf. mehrere), fachlicher Aspekt._ |
| Check Constraint | \<TabellenKürzel\>\_\<Qualifikation\>\_CK | emp_manager_ck,<br />_... constraint emp_manager_ck check (manager in (0,1))<br />Bsp. für \<Qualifikation\>: Spaltenname, Spaltenkürzel (ggf. mehrere), fachlicher Aspekt._ |
| Not Null Constraint | - (kein Name notwendig) | |


~ subtopic("Not Null Constraints")
~ rule()
Not Null constraints werden nicht namentlich ausgewiesen, da:

1. änderbar via

   ```sql
   alter table ... modifiy ... [not] null;
   ```

1. Weiterhin liefert die Fehlermeldung zur Constraint-Verletzung (ORA-01400) ausreichend Kontext um das Problem zu identifizieren.


~ topic("Indizes")
~ rule()

| Objekt-Typ | Regel | Beispiel |
|:---|:---|:---|
| Index | \<TabellenKürzel\>\_\<Qualifikation\>\_IX | emp_id_ix,<br />_Bsp. für \<Qualifikation\>: Spaltenname, Spaltenkürzel (ggf. mehrere), fachlicher Aspekt._ |



~ topic("Functions, Procedures, Types, Packages")
~ rule()
Functions, Procedures und Types _sollten_ bevorzugt in Packages abgelegt werden.

~ rule()
Functions, Procedures, Types und Packages _können_ mit einem Projektpräfix versehen werden.





~ topic("Synonyme")
~ rule()
Synonyme sind in einem Owner-Schema verboten.

~ rule()
Synonyme sind nur in einem Schema erlaubt, über die ein Fremdsystem auf ein Owner-Schema zugreift ("Access-Schema").

Nachteil: Müssen in diesem Fremdschema gepflegt werden, je nach Betriebskonzept bedeutet dies möglicherweise eine weitere Auslieferung des Access-Schemas.


~ subtopic("Öffentliche Synonyme")
~ rule()
Öffentliche Synonyme sind verboten.





~ topic("Jobs")

~ rule()
DBMS Jobs sind verboten. Es sind Scheduler Jobs zu verwenden.

_Warum?_ DBMS Jobs wurden durch Scheduler Jobs abgelöst.

~ rule()
Scheduler Jobs sind bevorzugt mit dem Job-Typ "STORED_PROCEDURE" anzulegen.

_Warum?_ für eine stored procedure ist sichergestellt, dass diese kompiliert. Das gilt nicht für Anonyme PL/SQL-Blöcke.



~ topic("Tablespaces")
~ rule()

| Objekt-Typ | Regel | Beispiel |
|:-----------|:------|:---------|
| Tablespace | \<DatenbankName\>_TS | MARKETING_TS, dieser Tablespace enthält _keine_ Indizes. |
| Index Tablespace | \<DatenbankName\>_IDX_TS | MARKETING_IDX_TS, dieser Tablespace enthält _ausschliesslich_ Indizes. |

Indizes sollten in ihrem eigenen Tablespace liegen.
Folglich sollte mindestens zwei Tablespaces pro Datenbank existieren.

Weitere Tablespaces können existieren.

_Warum?_ Indizes können komplett neu erstellt werden, sie enthalten keine wertvollen Daten.
Wenn eine Datenbank auf verschoben wird (von einem Host auf einen anderen, oder zu Backup-Zwecken), so muss der Index-Tablespace nicht bewegt werden.
Es können einfach die Indexe neu aufgebaut werden.


~ dumptoc ()
