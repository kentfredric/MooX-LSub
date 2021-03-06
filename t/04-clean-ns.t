
use strict;
use warnings;

use Test::Needs qw( Moo namespace::clean );
use Test::More tests => 3;

# ABSTRACT: Basic moo + clean namespaces test
require Moo;
require namespace::clean;
local $@;
my $failed = 1;
eval q[{
  package Sample;
  use Moo;
  use MooX::Lsub;
  use namespace::clean;

  lsub "method"    => sub { 5 };
  lsub "methodtwo" => sub { $_[0]->method + 1 };
  undef $failed;
}];

ok( !$failed, 'No Exceptions' ) or diag $@;
is( Sample->new()->method,    5, 'Injected lazy method returns value' );
is( Sample->new()->methodtwo, 6, 'Injected lazy method returns value' );
