


# Design and Naming Conventions for Databases


## Table of Contents

  1. [Language](#language)
  1. [Project Prefix](#project-prefix)
  1. [Table Name Abbreviations](#table-name-abbreviations)
  1. [Column Name Abbreviations](#column-name-abbreviations)
  1. [General Naming Conventions](#general-naming-conventions)
  1. [Tables](#tables)
  1. [Views](#views)
  1. [Triggers](#triggers)
  1. [Sequences](#sequences)
  1. [Columns](#columns)
  1. [Constraints](#constraints)
  1. [Indexes](#indexes)
  1. [Functions, Procedures, Types, Packages](#functions,-procedures,-types,-packages)
  1. [Synonyms](#synonyms)
  1. [Jobs](#jobs)
## Language
###### [Rule [R001](#rule-r001)]

The language used for naming schema objects is English.
A different language may be used for source code and documentation comments.

**[Back to top](#table-of-contents)**
## Project Prefix

###### [Rule [R002](#rule-r002)]
A project prefix _may_ be agreed. These prefixes are followed by an underscore ('_') and placed in front of every table or view name. A prefix comprises a maximum of 3 alphanumeric characters, starting with a letter.

_Why?_ Project prefixes are useful for identifying the use of tables or views in the application source code, especially when using embedded SQL or dynamic SQL (JDBC) in the source code. Alternatively, the schema can be consistently used.

**[Back to top](#table-of-contents)**
## Table Name Abbreviations

###### [Rule [R003](#rule-r003)]
A unique table name abbreviation _must_ be agreed for each table. All table name abbreviations and table names must be unique within their schema. A table name abbreviation comprises a maximum of 5 alphanumeric characters, starting with a letter. The table name abbreviation must be added to the comments for the table as follows:

  ```sql
  comment on table employee is 'abbrev=emp; ...';
  ```

Alternatively:

  ```sql
  comment on table employee is '...; abbrev=emp';
  ```

_Why?_ Among other things, this enables the automatic assignment of a sequence to a table.


**[Back to top](#table-of-contents)**
## Column Name Abbreviations
###### [Rule [R004](#rule-r004)]


A unique column name abbreviation _may_ be agreed for each column. A column name abbreviation comprises up to 6 alphanumeric characters, starting with a letter. The column name abbreviation may be included in the comment for the column as follows:

  ```sql
  comment on column employee.last_name is 'abbrev=empnam; ...';
  ```

Alternatively:

  ```sql
  comment on column employee.last_name is '...; abbrev=empnam';
  ```

**[Back to top](#table-of-contents)**
## General Naming Conventions
###### [Rule [R005](#rule-r005)]

All names comprise only the letters 'A'-'Z', the numbers '0'-'9', and an underscore '_'.
All names start with a letter.
All names are a maximum of 30 characters long.
Objects must always be created case-insensitive.
Names do not match reserved words or keywords.

**[Back to top](#table-of-contents)**
## Tables
###### [Rule [R006](#rule-r006)]

| Object Type | Rule | Example |
|:---|:---|:---|
| Tables | \<ProblemDomainName\> | employee |
| Journal tables | \<ProblemDomainName\>_JN | employee_jn,<br />_The table \<ProblemDomainName\> also exists as the basis of the journal._ |
| Logging tables | \<ProblemDomainName\>_LOG | import_log |
| DML error logging tables | \<ProblemDomainName\>_ERR| debtor_err,<br />_The table \<ProblemDomainName\> also exists as the basis for the associated DML statement._ |
| Backups/copies | \<ProblemDomainName\>_BAK| debtor_bak,<br />_The table \<ProblemDomainName\> also exists as the origin of the copy._ |

**[Back to top](#table-of-contents)**
## Views

###### [Rule [R007](#rule-r007)]
| Object Type | Rule | Example |
|:---|:---|:---|
| View | \<ProblemDomainName\>_V | employee_v,<br />_The table \<ProblemDomainName\> may also, but does not have to exist._ |


###### [Rule [R008](#rule-r008)]
Views are not nested.

_Why?_ Sooner or later, views nested within one another result in performance problems.

###### [Rule [R009](#rule-r009)]
Views are not permitted as part of an application access layer.

###### [Rule [R010](#rule-r010)]
Views are permitted:
- As a aid/convenience for developers or DBAs.
- To hide complexity (by denormalization) from external systems.
- To hide information in rows or columns (information hiding) from external systems.


**[Back to top](#table-of-contents)**
## Triggers

###### [Rule [R011](#rule-r011)]
There are 3 different types of triggers that may be used.
- Sequence triggers are used to populate the technical key column ID (before row insert).
- Auditing triggers are used to populate the auditing columns (before row insert/update).
- Journaling triggers are used to populate journaling tables (after row insert/update/delete).

###### [Rule [R012](#rule-r012)]
| Object Type | Rule | Example |
|:---|:---|:---|
| Sequence trigger | \<TableAbbreviation\>_SEQ_TG | emp_seq_tg |
| Journaling trigger | \<TableAbbreviation\>_JN_TG | emp_jn_tg |
| Auditing trigger | \<TableAbbreviation\>_AUD_TG | emp_aud_tg |

###### [Rule [R013](#rule-r013)]
The creation of other triggers is not permitted.

###### [Rule [R014](#rule-r014)]
As an alternative to triggers, an appropriate access layer must be implemented.

###### [Rule [R015](#rule-r015)]
All or nothing principle:
- If there is a technical key column being populated by a sequence trigger, it applies to all technical key columns.
- If there is an auditing trigger populating auditing columns, all auditing columns are populated by an auditing trigger.
- If there is a journal table being populated by a journaling trigger, it applies to all journal tables.Alles-oder-Nichts-Prinzip:

###### [Rule [R016](#rule-r016)]
All triggers should be created automatically, e.g. from a template.


**[Back to top](#table-of-contents)**
## Sequences

This section applies to sequences used to populate technical key columns. In principle, other sequences are permitted, but not included here owing to their infrequency.

###### [Rule [R017](#rule-r017)]

| Object Type | Rule | Example |
|:---|:---|:---|
| Sequence | \<TableAbbreviation\>_SEQ | emp_seq,<br />_For column ID of the table with the associated \<TableAbbreviation\>._ |

###### [Rule [R018](#rule-r018)]
Sequences always start with 1.

###### [Rule [R019](#rule-r019)]
Tables being populated by bulk inserts may use caching sequences.

###### [Rule [R020](#rule-r020)]
Example of a non-caching sequence used to populate the column ID of the table using the abbreviation _emp_:

  ```sql
  create sequence emp_seq nocycle nocache maxvalue 999999999999999999 minvalue 0 start with 1;
  ```


**[Back to top](#table-of-contents)**
## Columns

###### [Rule [R021](#rule-r021)]

| Object Type | Rule | Example |
|:---|:---|:---|
| Technical key column | ID | employee.id |
| Foreign key column | \<TableAbbreviation\>\_ID,<br />\<TableAbbreviation\>\_\<Qualification\>\_ID | employee.dep_id<br />_\<TableAbbreviation\> of the referenced table \<Qualification\> for multiple references._ |
| Auditing column,<br />creation date | CREATED_DATE | employee.created_date |
| Auditing column,<br />modification date | MODIFIED_DATE | employee.modified_date |
| Other columns | not 'ID', do not end with '_ID', no auditing column | employee.last_name |

**[Back to top](#table-of-contents)**
### Technical Keys
###### [Rule [R022](#rule-r022)]
Every table has a technical primary key. The table is referenced only by this primary key.
_Why?_ Domain keys may be subject to change. This way, they are uncoupled from the task of referential integrity.

###### [Rule [R023](#rule-r023)]
The technical key column is always named id. Joins must therefore always be created via the id column, not via domain keys, which may be subject to change.


###### [Rule [R024](#rule-r024)]
The technical key column is not nullable.
_Why?_ Data records can always be referenced this way.


###### [Rule [R025](#rule-r025)]
The technical key column is of type NUMBER(18,0)

  ```
  999.999.999.999.999.999 means:
  999.999 days each with 999 billion entries created.
  999.999 days corresponds to approx. 2,738 years
  ```

_Why?_ The id can easily fit into common data types, 64-bit signed integer (Java: long, C: int64_t/signed long long).

###### [Rule [R026](#rule-r026)]
The technical key column is always populated by a sequence. This preferably takes place in an access layer.


**[Back to top](#table-of-contents)**
### Auditing Columns
###### [Rule [R027](#rule-r027)]
Auditing columns are mandatory for all tables and must be maintained as well. This preferably takes place in an access layer.

###### [Rule [R028](#rule-r028)]
Auditing columns are not nullable, i.e. initial creation counts as modification.

###### [Rule [R029](#rule-r029)]
Auditing columns are usually of type Date.


**[Back to top](#table-of-contents)**
## Constraints
###### [Rule [R030](#rule-r030)]

| Object Type | Rule | Example |
|:---|:---|:---|
| Primary key constraint | \<TableAbbreviation\>\_PK | emp_pk |
| Unique constraint | \<TableAbbreviation\>\_\<Qualification\>\_UK | emp_username_uk,<br />_Example of \<Qualification\>: Column name, column name abbreviation (multiple, if required), domain aspect._ |
| Foreign key constraint | \<TableAbbreviation\>\_\<TableAbbreviation\>\_FK,<br />\<TableAbbreviation\>\_\<TableAbbreviation\>\_\<Qualification\>\_FK| emp_dep_fk,<br />_Example of <Qualification>: Column name, column name abbreviation (multiple, if required), domain aspect._ |
| Check constraint | \<TableAbbreviation\>\_\<Qualification\>\_CK | emp_manager_ck,<br />_... constraint emp_manager_ck check (manager in (0,1))<br />Example of <Qualification>: Column name, column name abbreviation (multiple, if required), domain aspect._ |
| NOT NULL constraint | - (no name necessary) | |


**[Back to top](#table-of-contents)**
### NOT NULL Constraints
###### [Rule [R031](#rule-r031)]
NOT NULL constraints are not identified by name, because:

1. They can be modified via

   ```sql
   alter table ... modifiy ... [not] null;
   ```

1. Furthermore, the error message for constraint violation (ORA-01400) provides enough context to identify the problem.


**[Back to top](#table-of-contents)**
## Indexes
###### [Rule [R032](#rule-r032)]

| Object Type | Rule | Example |
|:---|:---|:---|
| Index | \<TableAbbreviation\>\_\<Qualification\>\_IX | emp_id_ix,<br />_Example of <Qualification>: Column name, column name abbreviation (multiple, if required), domain aspect._ |


**[Back to top](#table-of-contents)**
## Functions, Procedures, Types, Packages
###### [Rule [R033](#rule-r033)]
Functions, procedures and types should preferably be stored in packages.

###### [Rule [R034](#rule-r034)]
Functions, procedures, types and packages may be assigned a project prefix.



**[Back to top](#table-of-contents)**
## Synonyms
###### [Rule [R035](#rule-r035)]
Synonyms are not permitted in owner schemas.

###### [Rule [R036](#rule-r036)]
Synonyms are only allowed in a schema used by an external system to access an application schema ("access schema").
_Drawbacks:_ If maintenance must be done in this external schema, this may mean further distribution of the access schema, depending on operating concept.



**[Back to top](#table-of-contents)**
### Public Synonyms
###### [Rule [R037](#rule-r037)]
Public synonyms are not permitted.



**[Back to top](#table-of-contents)**
## Jobs

###### [Rule [R038](#rule-r038)]
DBMS jobs are not permitted. Scheduler jobs must be used.
_Why?_ DBMS jobs have been replaced by scheduler jobs.

###### [Rule [R039](#rule-r039)]


Scheduler jobs should preferably be created with the job type "STORED_PROCEDURE".
_Why?_ a stored procedure is already compiled. This does not apply to anonymous PL/SQL blocks. Thus there can not be any compile time errors.


