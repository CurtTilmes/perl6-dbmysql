use Test;
use Test::When <extended>;

use DB::MySQL::Native;

ok DB::MySQL::Native.client-version, 'client-version';

ok DB::MySQL::Native.client-info, 'client-info';

