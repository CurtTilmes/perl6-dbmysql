use DB;
use DB::MySQL::Database;
use DB::MySQL::Native;

class DB::MySQL does DB
{
    has Str $.host = 'localhost';
    has Int $.port = 3306;
    has Str $.database = 'mysql';
    has Str $.user;
    has Str $.password;
    has Str $.socket;
    has Int $.flags = 0;

    method connect(--> DB::MySQL::Database)
    {
        my $conn = DB::MySQL::Native.init;

        if $conn.connect($!host, $!user, $!password, $!database, $!port,
                         $!socket, $!flags) === DB::MySQL::Native
        {
            die DB::MySQL::Error.new(message => $conn.error)
        }
        DB::MySQL::Database.new(:owner(self), :$conn)
    }
}

