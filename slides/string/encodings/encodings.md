!SLIDE title
# Encodings
## Turning code points into bytes


!SLIDE title
## Problem:
# There are more than 256 code points


!SLIDE title
## Solution:
# UTF-16


!SLIDE

```
U+2F49    ->        2F 49   (big endian)

              or    49 2F   (little endian)


$ irb

>> "\x2F\x49".force_encoding "utf-16be"
=> "\u2F49"

>> "\x2F\x49".force_encoding "utf-16le"
=> "\u492F"
```


!SLIDE title
## Problem:
# Which endianness is in use?


!SLIDE title
## Solution:
# Byte order mark


!SLIDE glyph
# &#xFEFF;
## ZERO WIDTH NO-BREAK SPACE
### U+FEFF


!SLIDE

```
>> "\xFE\xFF\x2F\x49".force_encoding "utf-16"
=> "\uFEFF\u2F49"

>> "\xFF\xFE\x2F\x49".force_encoding "utf-16"
=> "\uFEFF\u492F"
```


!SLIDE title
## Problem:
# There are more than 65,536 code points


!SLIDE title
## Solution:
# Surrogate pairs


!SLIDE title
# `U+D800` to `U+DFFF`<br>are reserved
## `U+D800` to `U+DBFF` are “high surrogates”
## `U+DC00` to `U+DFFF` are “low surrogates”


!SLIDE

```
>> hex "😱".encode("utf-16be").bytes
=> <D8 3D DE 31>

>> hex "😱".encode("utf-16le").bytes
=> <3D D8 31 DE>
```


!SLIDE

```
Supplementary code points are in the interval
[0x10000, 0x10FFFF]

Subtract 0x10000
=> [0, 0xFFFFF]

This gives (at most) 20 bits
```


!SLIDE

```
e.g.

>> code = 0x1F631   # U+1F631 = 😱

>> (code - 0x10000).to_s(2).rjust(20, "0")
=> "00001111011000110001"

To get code points, split into two 10-bit blocks

    0000111101      1000110001
    = 0x3D          = 0x231

    D800 + 3D       DC00 + 231
    = D83D          = DE31
```


!SLIDE

```
> code = 0x1F631
> c    = code - 0x10000

> pair = [ 0xD800 + (c >> 10),
           0xDC00 + (c & 0x3FF) ]

> pair.map(function(b) { return b.toString(16) })
[ 'd83d', 'de31' ]

> "\uD83D\uDE31"
'😱'
```


!SLIDE title
## Problem:
# Ugh, look at all these zeroes!


!SLIDE

```
>> hex "updog".encode("utf-16be").bytes
=> <00 75 00 70 00 64 00 6F 00 67>
```


!SLIDE title
## Solution:
# UTF-8


!SLIDE

```
>> hex "updog".encode("utf-16be").bytes
=> <00 75 00 70 00 64 00 6F 00 67>

>> hex "updog".encode("utf-8").bytes
=> <75 70 64 6F 67>
```


!SLIDE

```
For U+0000 to U+007F (up to 7 bits)

    e.g. a = U+0061
           = 1100001

                |
                V

                1100001
              0 1100001
                     61
```


!SLIDE

```
For U+0080 to U+07FF (up to 11 bits)

    e.g. ܞ = U+071E
           = 11100011110

                |
                V

     11100       011110
 110 11100    10 011110
        DC           9E
```


!SLIDE

```
For U+0800 to U+FFFF (up to 16 bits)

    e.g. ꕅ = U+A545
           = 1010010101000101

                |
                V

      1010       010101      000101
 1110 1010    10 010101   10 000101
        EA           95          85
```


!SLIDE

```
For U+10000 to U+10FFFF (up to 21 bits)

    e.g. 😱 = U+1F631
           = 000011111011000110001

                |
                V

       000       011111      011000      110001
 11110 000    10 011111   10 011000   10 110001
        F0           9F          98          B1
```


!SLIDE

```
Decoding UTF-8

e.g. E2 98 AD

      E2    11100010    1110|0010
      98    10011000    10|011000
      AD    10101101    10|101101

      0010 011000 101101 = 262D

      U+262D = ☭
```


!SLIDE title
# Validation


!SLIDE

```
  utf16be = [00-D7] [00-FF]
          | [E0-FF] [00-FF]
          | [D8-DB] [00-FF] [DC-DF] [00-FF]

  utf16le = [00-FF] [00-D7]
          | [00-FF] [E0-FF]
          | [00-FF] [D8-DB] [00-FF] [DC-DF]
```


!SLIDE

```
  utf8  = [00-7F]
        | [C2-DF] [80-BF]
        |      E0 [A0-BF] [80-BF]
        | [E1-EC] [80-BF] [80-BF]
        |      ED [80-9F] [80-BF]
        | [EE-EF] [80-BF] [80-BF]
        |      F0 [90-BF] [80-BF] [80-BF]
        | [F1-F3] [80-BF] [80-BF] [80-BF]
        |      F4 [80-8F] [80-BF] [80-BF]
```


!SLIDE

```
                          UTF-8       UTF-16

U+0000  to U+007F           1           2

U+0080  to U+07FF           2           2

U+0800  to U+FFFF           3           2

U+10000 to U+10FFFF         4           4
```
