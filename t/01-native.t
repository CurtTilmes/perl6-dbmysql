use Test;
use Test::When <extended>;

use DB::MySQL::Native;

say DB::MySQL::Native.client-version;

say DB::MySQL::Native.client-info;
