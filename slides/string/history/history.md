!SLIDE title
## Unix:
# “Everything’s a file”


!SLIDE title
## Unix:
# “Everything’s a <del>file</del>”


!SLIDE title
## Unix:
# “Everything’s a byte stream”


!SLIDE bullets

* Files on disk
* Data in memory
* Process stdio
* TCP streams
* Unix sockets


!SLIDE bullets

* Program source code
* Your terminal and text editor
* Records in the database
* HTML sent to the browser
* CSS and JavaScript


!SLIDE title
## *byte*, n.
# An atomic 8-bit value, denoted 00 to FF
## i.e. 0 to 255


!SLIDE

```
hex   binary  decimal     hex   binary  decimal
---------------------     ---------------------
  0     0000        0       8     1000        8
  1     0001        1       9     1001        9
  2     0010        2       A     1010       10
  3     0011        3       B     1011       11
  4     0100        4       C     1100       12
  5     0101        5       D     1101       13
  6     0110        6       E     1110       14
  7     0111        7       F     1111       15
``` 


!SLIDE diagram

```
                           B4
                          /  \
                       ---    ----
                      /           \
                    1011         0100
                    ^               ^
                    |               |
  most significant bit (MSB)    least significant bit (LSB)
  or, high-order bit            or, low-order bit


                     10110100 = 180
```


!SLIDE

```
    0x3FF       - 0x3 is 11
                - 0xF is 1111
                - 0xF is 1111

               so 0x3FF is 1111111111
```


!SLIDE title
## In the beginning* there was
# The American Standard Code for Information Interchange
## * 1963


!SLIDE map

```
00  NUL         08  BS  "\b"    10  DLE       18  CAN
01  SOH         09  HT  "\t"    11  DC1       19  EM
02  STX         0A  LF  "\n"    12  DC2       1A  SUB
03  ETX         0B  VT  "\v"    13  DC3       1B  ESC "\e"
04  EOT         0C  FF  "\f"    14  DC4       1C  FS
05  ENQ         0D  CR  "\r"    15  NAK       1D  GS
06  ACK         0E  SO          16  SYN       1E  RS
07  BEL "\a"    0F  SI          17  ETB       1F  US
```


!SLIDE map

```
20  SP  " "   30  0     40  @     50  P     60  `     70  p
21  !         31  1     41  A     51  Q     61  a     71  q
22  "         32  2     42  B     52  R     62  b     72  r
23  #         33  3     43  C     53  S     63  c     73  s
24  $         34  4     44  D     54  T     64  d     74  t
25  %         35  5     45  E     55  U     65  e     75  u
26  &         36  6     46  F     56  V     66  f     76  v
27  '         37  7     47  G     57  W     67  g     77  w
28  (         38  8     48  H     58  X     68  h     78  x
29  )         39  9     49  I     59  Y     69  i     79  y
2A  *         3A  :     4A  J     5A  Z     6A  j     7A  z
2B  +         3B  ;     4B  K     5B  [     6B  k     7B  {
2C  ,         3C  <     4C  L     5C  \     6C  l     7C  |
2D  -         3D  =     4D  M     5D  ]     6D  m     7D  }
2E  .         3E  >     4E  N     5E  ^     6E  n     7E  ~
2F  /         3F  ?     4F  O     5F  _     6F  o     7F  DEL
```


!SLIDE

```
    "0" = 0x30          "A" = 0x41
        = 0110000           = 1000001

    "1" = 0x31          "B" = 0x42
        = 0110001           = 1000010

    "9" = 0x39          --
        = 0111001
                        "a" = 0x61
                            = 1100001

                        "b" = 0x62
                            = 1100010
```


!SLIDE title
# ISO 8859-1
## a.k.a. iso-ir-100, csISOLatin1, latin1, l1, IBM819, CP819


!SLIDE map

```
00-7F: like ASCII
80-9F: <unassigned>

A0  NBSP  B0  °     C0  À     D0  Ð     E0  à     F0  ð
A1  ¡     B1  ±     C1  Á     D1  Ñ     E1  á     F1  ñ
A2  ¢     B2  ²     C2  Â     D2  Ò     E2  â     F2  ò
A3  £     B3  ³     C3  Ã     D3  Ó     E3  ã     F3  ó
A4  ¤     B4  ´     C4  Ä     D4  Ô     E4  ä     F4  ô
A5  ¥     B5  µ     C5  Å     D5  Õ     E5  å     F5  õ
A6  ¦     B6  ¶     C6  Æ     D6  Ö     E6  æ     F6  ö
A7  §     B7  ·     C7  Ç     D7  ×     E7  ç     F7  ÷
A8  ¨     B8  ¸     C8  È     D8  Ø     E8  è     F8  ø
A9  ©     B9  ¹     C9  É     D9  Ù     E9  é     F9  ù
AA  ª     BA  º     CA  Ê     DA  Ú     EA  ê     FA  ú
AB  «     BB  »     CB  Ë     DB  Û     EB  ë     FB  û
AC  ¬     BC  ¼     CC  Ì     DC  Ü     EC  ì     FC  ü
AD  SHY   BD  ½     CD  Í     DD  Ý     ED  í     FD  ý
AE  ®     BE  ¾     CE  Î     DE  Þ     EE  î     FE  þ
AF  ¯     BF  ¿     CF  Ï     DF  ß     EF  ï     FF  ÿ
```


!SLIDE title
# Windows-1252
## or, CP-1252


!SLIDE

```
00-7F: like ASCII
A0-FF: like ISO 8859-1

80  €         88  ˆ         90            98  ˜
81            89  ‰         91  ‘         99  ™
82  ‚         8A  Š         92  ’         9A  š
83  ƒ         8B  ‹         93  “         9B  ›
84  „         8C  Œ         94  ”         9C  œ
85  …         8D            95  •         9D
86  †         8E  Ž         96  –         9E  ž
87  ‡         8F            97  —         9F  Ÿ
```
