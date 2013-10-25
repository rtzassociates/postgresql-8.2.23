.\\" auto-generated by docbook2man-spec $Revision: 1.1.1.1 $
.TH "SET CONSTRAINTS" "" "2011-12-01" "SQL - Language Statements" "SQL Commands"
.SH NAME
SET CONSTRAINTS \- set constraint checking modes for the current transaction

.SH SYNOPSIS
.sp
.nf
SET CONSTRAINTS { ALL | \fIname\fR [, ...] } { DEFERRED | IMMEDIATE }
.sp
.fi
.SH "DESCRIPTION"
.PP
\fBSET CONSTRAINTS\fR sets the behavior of constraint
checking within the current transaction. IMMEDIATE
constraints are checked at the end of each
statement. DEFERRED constraints are not checked until
transaction commit. Each constraint has its own
IMMEDIATE or DEFERRED mode.
.PP
Upon creation, a constraint is given one of three
characteristics: DEFERRABLE INITIALLY DEFERRED,
DEFERRABLE INITIALLY IMMEDIATE, or
NOT DEFERRABLE. The third
class is always IMMEDIATE and is not affected by the
\fBSET CONSTRAINTS\fR command. The first two classes start
every transaction in the indicated mode, but their behavior can be changed
within a transaction by \fBSET CONSTRAINTS\fR.
.PP
\fBSET CONSTRAINTS\fR with a list of constraint names changes
the mode of just those constraints (which must all be deferrable). The
current schema search path is used to find the first matching name if
no schema name is specified. \fBSET CONSTRAINTS ALL\fR 
changes the mode of all deferrable constraints.
.PP
When \fBSET CONSTRAINTS\fR changes the mode of a constraint
from DEFERRED
to IMMEDIATE, the new mode takes effect
retroactively: any outstanding data modifications that would have
been checked at the end of the transaction are instead checked during the
execution of the \fBSET CONSTRAINTS\fR command.
If any such constraint is violated, the \fBSET CONSTRAINTS\fR
fails (and does not change the constraint mode). Thus, \fBSET
CONSTRAINTS\fR can be used to force checking of constraints to
occur at a specific point in a transaction.
.PP
Currently, only foreign key constraints are affected by this
setting. Check and unique constraints are always effectively
not deferrable.
.SH "NOTES"
.PP
This command only alters the behavior of constraints within the
current transaction. Thus, if you execute this command outside of a
transaction block
(\fBBEGIN\fR/\fBCOMMIT\fR pair), it will
not appear to have any effect.
.SH "COMPATIBILITY"
.PP
This command complies with the behavior defined in the SQL
standard, except for the limitation that, in
PostgreSQL, it only applies to
foreign-key constraints.