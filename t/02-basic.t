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

is $mysql.query('insert into foo (x,y) values (?,?)', 2, 'that'),
    1, 'Insert another value';

is-deeply $mysql.query('select * from foo where x = ?', 1).array,
    (1, 'this'), 'select array';

is-deeply $mysql.query('select * from foo where x = ?', 2).hash,
    %( x => 2, y => 'that' ), 'select hash';

is-deeply $mysql.execute('select * from foo order by x').arrays,
    ( (1, 'this'), (2, 'that') ), 'select arrays';

is-deeply $mysql.execute('select * from foo order by x').hashes,
    ( %(x => 1, y => 'this'), %(x => 2, y => 'that') ), 'select hashes';

is $mysql.execute('drop table foo'), 0, 'Drop table';
