.\\" auto-generated by docbook2man-spec $Revision: 1.1.1.1 $
.TH "DROP OPERATOR CLASS" "" "2011-12-01" "SQL - Language Statements" "SQL Commands"
.SH NAME
DROP OPERATOR CLASS \- remove an operator class

.SH SYNOPSIS
.sp
.nf
DROP OPERATOR CLASS [ IF EXISTS ] \fIname\fR USING \fIindex_method\fR [ CASCADE | RESTRICT ]
.sp
.fi
.SH "DESCRIPTION"
.PP
\fBDROP OPERATOR CLASS\fR drops an existing operator class.
To execute this command you must be the owner of the operator class.
.SH "PARAMETERS"
.TP
\fBIF EXISTS\fR
Do not throw an error if the operator class does not exist. A notice is issued 
in this case.
.TP
\fB\fIname\fB\fR
The name (optionally schema-qualified) of an existing operator class.
.TP
\fB\fIindex_method\fB\fR
The name of the index access method the operator class is for.
.TP
\fBCASCADE\fR
Automatically drop objects that depend on the operator class.
.TP
\fBRESTRICT\fR
Refuse to drop the operator class if any objects depend on it.
This is the default.
.SH "EXAMPLES"
.PP
Remove the B-tree operator class widget_ops:
.sp
.nf
DROP OPERATOR CLASS widget_ops USING btree;
.sp
.fi
This command will not succeed if there are any existing indexes
that use the operator class. Add CASCADE to drop
such indexes along with the operator class.
.SH "COMPATIBILITY"
.PP
There is no \fBDROP OPERATOR CLASS\fR statement in the
SQL standard.
.SH "SEE ALSO"
ALTER OPERATOR CLASS [\fBalter_operator_class\fR(l)], CREATE OPERATOR CLASS [\fBcreate_operator_class\fR(l)]