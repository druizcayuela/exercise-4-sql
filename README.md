# exercise-4-sql

I have a table for bugs from a bug tracking software; let’s call the table “bugs”.

The table has four columns (id, open_date, close_date, severity). On any given day

a bug is open if the open_date is on or before that day and close_date is after

that day. For example, a bug is open on “2012-01-01”, if it’s created on or

before “2012-01-01” and closed on or after “2012-01-02”. I want an SQL to show

the number of bugs open each day for a range of dates. Hint: There are bugs that were

never closed.
