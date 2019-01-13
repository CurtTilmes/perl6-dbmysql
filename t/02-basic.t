use Test;
use Test::When <extended>;

use DB::MySQL;

#plan 10;

my $host = '127.0.0.1';
my $user = 'root';
my $password = 'this';
my $database = 'testing';

isa-ok my $s = DB::MySQL.new(:$host, :$user, :$password, :$database),
    DB::MySQL, 'Create object';

isa-ok my $db = $s.db, DB::MySQL::Database, 'Create database handle';

#say $db.execute("select * from this").hashes;

#my $sth = $db.prepare("select CONVERT(?,DECIMAL(12,4))");

#dd $sth.execute(4.234).value;

#say $db.execute("select ? as a,? as b,? as c").hashes;

my $sth = $db.prepare("select ? as a, ? as b");

say $sth.execute(12, 'this').hashes;

say $sth.execute(12, 'this is bigger', :finish).array;

#$sth.finish;

#say $s.query('select 1, 3').hashes;
