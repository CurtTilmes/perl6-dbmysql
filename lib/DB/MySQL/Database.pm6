use DB::Database;
use DB::MySQL::Native;
use DB::MySQL::Statement;

class DB::MySQL::Database does DB::Database
{
    has DB::MySQL::Native $.conn handles <client-version client-info host-info
                                          server-info server-version
                                          proto-info ssl-cipher select-db
                                          stat info check insert-id>;

    method ping(--> Bool) { $!conn.ping == 0 }

    method execute(Str:D $command, Bool :$finish)
    {
        $!conn.query($command);

        my $result = $!conn.check.store-result
                     // return $!conn.check.affected-rows;

        DB::MySQL::NonStatementResult.new(:db(self), :$result, :$finish);
    }

    method prepare-nocache(Str:D $query --> DB::MySQL::Statement)
    {
        my $stmt = $!conn.stmt-init // $!conn.check;
        $stmt.prepare($query);
        DB::MySQL::Statement.new(:db(self), :$stmt)
    }

    submethod DESTROY(--> Nil)
    {
        .close with $!conn;
        $!conn = Nil;
    }
}
