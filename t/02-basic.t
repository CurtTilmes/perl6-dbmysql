use Test;
use Test::When <extended>;

use DB::MySQL;

#plan 10;

isa-ok my $mysql = DB::MySQL.new(), DB::MySQL, 'Create object';

is $mysql.execute('select 42').value, 42, 'Simple query';

is $mysql.execute('create table foo (x int, y varchar(80))'),
    0, 'Create table';

is $mysql.query('insert into foo (x,y) values (?,?)', 1, 'this'),
    1, 'Insert value';

say $mysql.query('select * from foo where x = ?', 1).array;
say $mysql.query('select * from foo where x = ?', 1).hash;
