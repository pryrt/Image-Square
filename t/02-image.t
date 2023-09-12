#!perl
use 5.010;
use strict;
use warnings;
use Test::More;

eval "use Digest::MD5 qw(md5_hex)";

plan skip_all => "Skipping tests: Digest::MD5 not available!" if $@;

plan tests => 11;

use Image::Square;

# Hashes of visually tested images
my %hash = (
    'hor_square'   => '2fd6c32b1f76518800283c196ed67262',
    'hor_left'     => '9a7360d94551f1a65ac7a574a688d7e1',
    'hor_right'    => 'bf4f292694fed8ae230ce946c5fc3c92',
    'ver_square'   => '875febb115891ee3e57f399f46f2cd75',
    'ver_top'      => 'c15bd1a20657ccb4026c838bc0bc88cb',
    'ver_bottom'   => '10680482610d168be928770792e70aeb',
);

# Test horizontal iamge
my $image = Image::Square->new('t/CoventryCathedral.png');

ok ($image, 'Instantiation');

diag('Testing horizontal image');

my $square1 = $image->square();
my $square2 = $image->square(100);
my $square3 = $image->square(150, 0);
my $square4 = $image->square(150, 1);

ok ($square1->width == $square1->height, 'Image is square from horizontal');

ok ( 100 == $square2->width && 100 == $square2->height, 'Correct resize from horizontal');

ok ( md5_hex($square2->png(5)) eq $hash{'hor_square'}, 'Correct centre image from horizontal');

ok ( md5_hex($square3->png(5)) eq $hash{'hor_left'}, 'Correct left image from horizontal');

ok ( md5_hex($square4->png(5)) eq $hash{'hor_right'}, 'Correct right image from horizontal');

# Test vertical iamge
$image = Image::Square->new('t/decoration.png');

diag('Testing vertical image');

my $square5 = $image->square();
my $square6 = $image->square(100);
my $square7 = $image->square(150, 0);
my $square8 = $image->square(150, 1);

ok ($square5->width == $square5->height, 'Image is square from vertical');

ok ($square6->width == 100 && $square6->height == 100, 'Correct resize from vertical');

ok ( md5_hex($square6->png(5)) eq $hash{'ver_square'}, 'Correct centre image from vertical');

ok ( md5_hex($square7->png(5)) eq $hash{'ver_top'}, 'Correct top image from vertical');

ok ( md5_hex($square8->png(5)) eq $hash{'ver_bottom'}, 'Correct bottom image from vertical');

done_testing;



