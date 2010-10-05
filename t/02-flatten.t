use strict;
use warnings;
use Test::More tests => 2;
use Dancer::FileUtils 'path';

use Dancer::Template::HtmlTemplate;

my $engine;
eval { $engine = Dancer::Template::HtmlTemplate->new };
is $@, '',
  "Dancer::Template::HtmlTemplate engine created";

my $template = path('t', 'index2.tt');
my $result = $engine->render(
    $template,
    {   var => 0,
        foo  => {
            bar => 1,
            baz => {
                klong => 2,
                gruh => 3,
            },
            array => [ qw(one two three four) ],
        },
    }
);

my $expected =
  qq(
this is var="0"
this is foo.bar="1"
this is foo.baz.klong="2"
this is foo.array.2="three"
this is foo=""
);
is $result, $expected, "flatten hashes and arrays";