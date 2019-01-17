DB::MySQL - MySQL access for Perl 6
===================================

This is a reimplementation of Perl 6 bindings for MySQL.

Basic usage
-----------

```perl6
use DB::MySQL;
my $mysql = DB::MySQL.new();  # You can pass in various options
```

Execute a query, and get a single value:
```perl6
say $mysql.execute('select 42').value;
# 42
```

Create a table:
```perl6
$mysql.execute('create table foo (x int, y varchar(80))');
```

Insert some values using placeholders:
```perl6
$mysql.query('insert into foo (x,y) values (?,?)', 1, 'this');
```

Execute a query returning a row as an array or hash;
```perl6
say $mysql.query('select * from foo where x = ?', 1).array;
say $mysql.query('select * from foo where x = ?', 1).hash;
```

Execute a query returning a bunch of rows as arrays or hashes:

```perl6
.say for $mysql.query('select * from foo').arrays;
.say for $mysql.query('select * from foo').hashes;
```

`.query()` caches a prepared statement, and can have placeholders and
arguments - `.execute()` does not prepare/cache and can't have
placeholders.  Both can return results.

Installation
------------

This module relies on `libmysqlclient.so`.  For Ubuntu, I install this
with:

```
sudo apt install libmysqlclient-dev
```

I worked with version 5.7 of the API.  It may or may not work with
other versions.  You can see the client version with:

```
perl6 -MDB::MySQL::Native -e 'say mysql_get_client_info'
```

There are likely 64-bit Linux dependencies in the code.  Patches
welcome if someone wants to make it on other OSes.
