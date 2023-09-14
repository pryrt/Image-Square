#!perl
use 5.010;
use strict;
use warnings;
use Test::More tests => 16;

use Image::Square;

# Test horizontal iamge
my $image = Image::Square->new('t/3x1.png');
isa_ok $image, 'Image::Square', 'Image';

# size is calculated as 1, pos defaults to 0.5, so should be the middle pixel
#   covers: undefined size for horizontal
#   covers: undefined pos => 0.5
#           via correct pixel is extracted from original (showing that pos is okay)
my $square = $image->square();
cmp_ok $square->width, '==', $square->height, 'Horizontal: 3x1->square(): Image is square';
is $square->width, $image->{'gd'}->height, 'Horizontal: 3x1->square(): Image width same as input height';
is $square->getPixel(0,0), 0x00FF00, 'Horizontal: 3x1->square(): Pixel is green (0x00FF00)';

# size is forced to enlarge, pos defaults to 0.5, so the middle pixel should be enlarged to something bigger
#   covers: size is defined (and forced to enlarge)
$square = $image->square(10);
cmp_ok $square->width, '==', $square->height, 'Horizontal: 3x1->square(10): Image is square';
is $square->width, 10, 'Horizontal: 3x1->square(10): Image width from parameter';
is $square->getPixel(0,0), 0x00FF00, 'Horizontal: 3x1->square(10): Upper-Left Pixel is green (0x00FF00), from the center pixel of 3x1';
is $square->getPixel(9,0), 0x00FF00, 'Horizontal: 3x1->square(10): Upper-Right Pixel is green (0x00FF00), from the center pixel of 3x1';
is $square->getPixel(0,9), 0x00FF00, 'Horizontal: 3x1->square(10): Lower-Left Pixel is green (0x00FF00), from the center pixel of 3x1';
is $square->getPixel(9,9), 0x00FF00, 'Horizontal: 3x1->square(10): Lower-Right Pixel is green (0x00FF00), from the center pixel of 3x1';

# size is back to 1, pos is set to known value
#   covers: size and pos are both explicit
$square = $image->square(1,0);
cmp_ok $square->width, '==', $square->height, 'Horizontal: 3x1->square(1,0): Image is square';
is $square->width, 1, 'Horizontal: 3x1->square(1,0): Image width from parameter';
is $square->getPixel(0,0), 0xFF0000, 'Horizontal: 3x1->square(1,0): Pixel is red (0xFF0000), from the left pixel of 3x1';

# size is back to 1, pos is set to different known value
#   covers: size and pos are both explicit
$square = $image->square(1,1);
cmp_ok $square->width, '==', $square->height, 'Horizontal: 3x1->square(1,1): Image is square';
is $square->width, 1, 'Horizontal: 3x1->square(1,1): Image width from parameter';
is $square->getPixel(0,0), 0x0000FF, 'Horizontal: 3x1->square(1,1): Pixel is blue (0x0000FF), from the right pixel of 3x1';

done_testing();
