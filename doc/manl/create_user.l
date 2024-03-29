.\\" auto-generated by docbook2man-spec $Revision: 1.1.1.1 $
.TH "CREATE USER" "" "2011-12-01" "SQL - Language Statements" "SQL Commands"
.SH NAME
CREATE USER \- define a new database role

.SH SYNOPSIS
.sp
.nf
CREATE USER \fIname\fR [ [ WITH ] \fIoption\fR [ ... ] ]

where \fIoption\fR can be:
    
      SUPERUSER | NOSUPERUSER
    | CREATEDB | NOCREATEDB
    | CREATEROLE | NOCREATEROLE
    | CREATEUSER | NOCREATEUSER
    | INHERIT | NOINHERIT
    | LOGIN | NOLOGIN
    | CONNECTION LIMIT \fIconnlimit\fR
    | [ ENCRYPTED | UNENCRYPTED ] PASSWORD '\fIpassword\fR'
    | VALID UNTIL '\fItimestamp\fR' 
    | IN ROLE \fIrolename\fR [, ...]
    | IN GROUP \fIrolename\fR [, ...]
    | ROLE \fIrolename\fR [, ...]
    | ADMIN \fIrolename\fR [, ...]
    | USER \fIrolename\fR [, ...]
    | SYSID \fIuid\fR 
.sp
.fi
.SH "DESCRIPTION"
.PP
\fBCREATE USER\fR is now an alias for
CREATE ROLE [\fBcreate_role\fR(l)].
The only difference is that when the command is spelled
\fBCREATE USER\fR, LOGIN is assumed
by default, whereas NOLOGIN is assumed when
the command is spelled
\fBCREATE ROLE\fR.
.SH "COMPATIBILITY"
.PP
The \fBCREATE USER\fR statement is a
PostgreSQL extension. The SQL standard
leaves the definition of users to the implementation.
.SH "SEE ALSO"
CREATE ROLE [\fBcreate_role\fR(l)]
