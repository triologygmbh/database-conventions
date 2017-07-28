~ -- include functions
~ dofile ("src/functions")

~ -- set language
~ language = "en";


# Design and Naming Conventions for Databases


## Table of Contents

~ -- deferred inclusion of toc for second pass...
~ io.write("~ incl('toc.tmp')")

~ topic ("Language")
~ rule()

The language used for naming schema objects is English.
A different language may be used for source code and documentation comments.

~ topic ("Project Prefix")

~ rule()
A project prefix _may_ be agreed. These prefixes are followed by an underscore ('_') and placed in front of every table or view name. A prefix comprises a maximum of 3 alphanumeric characters, starting with a letter.

_Why?_ Project prefixes are useful for identifying the use of tables or views in the application source code, especially when using embedded SQL or dynamic SQL (JDBC) in the source code. Alternatively, the schema can be consistently used.

~ topic ("Table Name Abbreviations")

~ rule()
A unique table name abbreviation _must_ be agreed for each table. All table name abbreviations and table names must be unique within their schema. A table name abbreviation comprises a maximum of 5 alphanumeric characters, starting with a letter. The table name abbreviation must be added to the comments for the table as follows:

  ```sql
  comment on table employee is 'abbrev=emp; ...';
  ```

Alternatively:

  ```sql
  comment on table employee is '...; abbrev=emp';
  ```

_Why?_ Among other things, this enables the automatic assignment of a sequence to a table.


~ topic ("Column Name Abbreviations")
~ rule()


A unique column name abbreviation _may_ be agreed for each column. A column name abbreviation comprises up to 6 alphanumeric characters, starting with a letter. The column name abbreviation may be included in the comment for the column as follows:

  ```sql
  comment on column employee.last_name is 'abbrev=empnam; ...';
  ```

Alternatively:

  ```sql
  comment on column employee.last_name is '...; abbrev=empnam';
  ```

~ topic("General Naming Conventions")
~ rule()

All names comprise only the letters 'A'-'Z', the numbers '0'-'9', and an underscore '_'.
All names start with a letter.
All names are a maximum of 30 characters long.
Objects must always be created case-insensitive.
Names do not match reserved words or keywords.

~ topic("Tables")
~ rule()

| Object Type | Rule | Example |
|:---|:---|:---|
| Tables | \<ProblemDomainName\> | employee |
| Journal tables | \<ProblemDomainName\>_JN | employee_jn,<br />_The table \<ProblemDomainName\> also exists as the basis of the journal._ |
| Logging tables | \<ProblemDomainName\>_LOG | import_log |
| DML error logging tables | \<ProblemDomainName\>_ERR| debtor_err,<br />_The table \<ProblemDomainName\> also exists as the basis for the associated DML statement._ |
| Backups/copies | \<ProblemDomainName\>_BAK| debtor_bak,<br />_The table \<ProblemDomainName\> also exists as the origin of the copy._ |

~ topic("Views")

~ rule()
| Object Type | Rule | Example |
|:---|:---|:---|
| View | \<ProblemDomainName\>_V | employee_v,<br />_The table \<ProblemDomainName\> may also, but does not have to exist._ |


~ rule()
Views are not nested.

_Why?_ Sooner or later, views nested within one another result in performance problems.

~ rule()
Views are not permitted as part of an application access layer.

~ rule()
Views are permitted:
- As a aid/convenience for developers or DBAs.
- To hide complexity (by denormalization) from external systems.
- To hide information in rows or columns (information hiding) from external systems.


~ topic("Triggers")

~ rule()
There are 3 different types of triggers that may be used.
- Sequence triggers are used to populate the technical key column ID (before row insert).
- Auditing triggers are used to populate the auditing columns (before row insert/update).
- Journaling triggers are used to populate journaling tables (after row insert/update/delete).

~ rule()
| Object Type | Rule | Example |
|:---|:---|:---|
| Sequence trigger | \<TableAbbreviation\>_SEQ_TG | emp_seq_tg |
| Journaling trigger | \<TableAbbreviation\>_JN_TG | emp_jn_tg |
| Auditing trigger | \<TableAbbreviation\>_AUD_TG | emp_aud_tg |

~ rule()
The creation of other triggers is not permitted.

~ rule()
As an alternative to triggers, an appropriate access layer must be implemented.

~ rule()
All or nothing principle:
- If there is a technical key column being populated by a sequence trigger, it applies to all technical key columns.
- If there is an auditing trigger populating auditing columns, all auditing columns are populated by an auditing trigger.
- If there is a journal table being populated by a journaling trigger, it applies to all journal tables.Alles-oder-Nichts-Prinzip:

~ rule ()
All triggers should be created automatically, e.g. from a template.


~ topic("Sequences")

This section applies to sequences used to populate technical key columns. In principle, other sequences are permitted, but not included here owing to their infrequency.

~ rule()

| Object Type | Rule | Example |
|:---|:---|:---|
| Sequence | \<TableAbbreviation\>_SEQ | emp_seq,<br />_For column ID of the table with the associated \<TableAbbreviation\>._ |

~ rule()
Sequences always start with 1.

~ rule()
Tables being populated by bulk inserts may use caching sequences.

~ rule()
Example of a non-caching sequence used to populate the column ID of the table using the abbreviation _emp_:

  ```sql
  create sequence emp_seq nocycle nocache maxvalue 999999999999999999 minvalue 0 start with 1;
  ```


~ topic("Columns")

~ rule()

| Object Type | Rule | Example |
|:---|:---|:---|
| Technical key column | ID | employee.id |
| Foreign key column | \<TableAbbreviation\>\_ID,<br />\<TableAbbreviation\>\_\<Qualification\>\_ID | employee.dep_id<br />_\<TableAbbreviation\> of the referenced table \<Qualification\> for multiple references._ |
| Auditing column,<br />creation date | CREATED_DATE | employee.created_date |
| Auditing column,<br />modification date | MODIFIED_DATE | employee.modified_date |
| Other columns | not 'ID', do not end with '_ID', no auditing column | employee.last_name |

~ subtopic ("Technical Keys")
~ rule()
Every table has a technical primary key. The table is referenced only by this primary key.
_Why?_ Domain keys may be subject to change. This way, they are uncoupled from the task of referential integrity.

~ rule()
The technical key column is always named id. Joins must therefore always be created via the id column, not via domain keys, which may be subject to change.


~ rule()
The technical key column is not nullable.
_Why?_ Data records can always be referenced this way.


~ rule()
The technical key column is of type NUMBER(18,0)

  ```
  999.999.999.999.999.999 means:
  999.999 days each with 999 billion entries created.
  999.999 days corresponds to approx. 2,738 years
  ```

_Why?_ The id can easily fit into common data types, 64-bit signed integer (Java: long, C: int64_t/signed long long).

~ rule()
The technical key column is always populated by a sequence. This preferably takes place in an access layer.


~ subtopic ("Auditing Columns")
~ rule()
Auditing columns are mandatory for all tables and must be maintained as well. This preferably takes place in an access layer.

~ rule()
Auditing columns are not nullable, i.e. initial creation counts as modification.

~ rule()
Auditing columns are usually of type Date.


~ topic("Constraints")
~ rule()

| Object Type | Rule | Example |
|:---|:---|:---|
| Primary key constraint | \<TableAbbreviation\>\_PK | emp_pk |
| Unique constraint | \<TableAbbreviation\>\_\<Qualification\>\_UK | emp_username_uk,<br />_Example of \<Qualification\>: Column name, column name abbreviation (multiple, if required), domain aspect._ |
| Foreign key constraint | \<TableAbbreviation\>\_\<TableAbbreviation\>\_FK,<br />\<TableAbbreviation\>\_\<TableAbbreviation\>\_\<Qualification\>\_FK| emp_dep_fk,<br />_Example of <Qualification>: Column name, column name abbreviation (multiple, if required), domain aspect._ |
| Check constraint | \<TableAbbreviation\>\_\<Qualification\>\_CK | emp_manager_ck,<br />_... constraint emp_manager_ck check (manager in (0,1))<br />Example of <Qualification>: Column name, column name abbreviation (multiple, if required), domain aspect._ |
| NOT NULL constraint | - (no name necessary) | |


~ subtopic("NOT NULL Constraints")
~ rule()
NOT NULL constraints are not identified by name, because:

1. They can be modified via

   ```sql
   alter table ... modifiy ... [not] null;
   ```

1. Furthermore, the error message for constraint violation (ORA-01400) provides enough context to identify the problem.


~ topic("Indexes")
~ rule()

| Object Type | Rule | Example |
|:---|:---|:---|
| Index | \<TableAbbreviation\>\_\<Qualification\>\_IX | emp_id_ix,<br />_Example of <Qualification>: Column name, column name abbreviation (multiple, if required), domain aspect._ |


~ topic("Functions, Procedures, Types, Packages")
~ rule()
Functions, procedures and types should preferably be stored in packages.

~ rule()
Functions, procedures, types and packages may be assigned a project prefix.



~ topic("Synonyms")
~ rule()
Synonyms are not permitted in owner schemas.

~ rule()
Synonyms are only allowed in a schema used by an external system to access an application schema ("access schema").
_Drawbacks:_ If maintenance must be done in this external schema, this may mean further distribution of the access schema, depending on operating concept.



~ subtopic("Public Synonyms")
~ rule()
Public synonyms are not permitted.



~ topic("Jobs")

~ rule()
DBMS jobs are not permitted. Scheduler jobs must be used.
_Why?_ DBMS jobs have been replaced by scheduler jobs.

~ rule()


Scheduler jobs should preferably be created with the job type "STORED_PROCEDURE".
_Why?_ a stored procedure is already compiled. This does not apply to anonymous PL/SQL blocks. Thus there can not be any compile time errors.


~ dumptoc ()
