use strict;
use warnings;

use Test::More;
use URI;

plan skip_all => 'this test assumes that URI::javascript does not exist'
    if eval { +require URI::javascript };
plan tests => 6;

{
  require URI::_foreign; # load this before disabling @INC
  my $count = 0;
  local @INC = sub {$count++; return};
  for (0..1) {
    my $uri = URI->new('javascript://foo/bar');
    is($count, 1, 'only attempt to load the scheme package once');
    is($@, '', 'no exception when trying to load a scheme handler class');
    ok($uri->isa('URI'), 'but URI still instantiated as foreign');
  }
}
