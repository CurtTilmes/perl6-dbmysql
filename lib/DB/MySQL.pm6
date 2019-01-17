use DB;
use DB::MySQL::Connection;
use DB::MySQL::Native;

class DB::MySQL does DB
{
    has Str $.host = '127.0.0.1';
    has Int $.port = 3306;
    has Str $.database;
    has Str $.user;
    has Str $.password;
    has Str $.socket;
    has Int $.flags = 0;
    has Str $.group = 'client';
    has Int $.connect-timeout;
    has Lock $.lock .= new;       # Just because I'm paranoid, should I remove?

    method connect(--> DB::MySQL::Connection)
    {
        my $conn = $!lock.protect: { DB::MySQL::Native.init }

        $conn.option(MYSQL_READ_DEFAULT_GROUP, $_) with $!group;

        $conn.option(MYSQL_OPT_CONNECT_TIMEOUT, $_) with $!connect-timeout;

        $conn.connect($!host, $!user, $!password, $!database, $!port,
                      $!socket, $!flags) // $conn.check;

        DB::MySQL::Connection.new(:owner(self), :$conn)
    }
}
