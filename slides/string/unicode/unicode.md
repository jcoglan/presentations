!SLIDE

> The idea of expanding the basis for character encoding from 8 to 16 bits is so
> sensible, indeed so obvious, that the mind initially recoils from it. There
> must be a catch to it…
>
> Are 16 bits, providing at most 65,536 distinct codes, sufficient to encode all
> characters of all the world’s scripts? Since the definition of a “character”
> is itself part of the design of a text encoding scheme, the question is
> meaningless unless it is restated as: Is it possible to engineer a reasonable
> definition of “character” such that all the world’s scripts contain fewer than
> 65,536 of them?
>
> The answer to this is Yes.
>
> – Joseph D. Becker PhD, _Unicode 88_


!SLIDE title
# “640 K ought to be enough for anybody”
## – Bill Gates


!SLIDE
## (actually Bill Gates never said this)


!SLIDE title
# Unicode


!SLIDE title
# Separate representation from encoding


!SLIDE title
# 0x110000 “code points”
## `U+0000` to `U+10FFFF`


!SLIDE title
# That’s 1,114,112
## (Not all of them are used yet)


!SLIDE title
# 17 “planes”
## Each with 0x10000 (65,536) code points
## http://en.wikipedia.org/wiki/Unicode


!SLIDE map

```
0:     U+0000  to U+FFFF   Basic Multilingual Plane

1:     U+10000 to U+1FFFF  Supplementary Multilingual Plane

2:     U+20000 to U+2FFFF  Supplementary Ideographic Plane

3-13:  U+30000 to U+DFFFF  <unassigned>

14:    U+E0000 to U+EFFFF  Supplementary Special-purpose Plane

15-16: U+F0000 to U+10FFFF Supplementary Private Use Area
```


!SLIDE title
# The BMP
## Basic Multilingual Plane
## `U+0000` to `U+FFFF`


!SLIDE glyph
# A
## LATIN CAPITAL LETTER A
### U+0041


!SLIDE glyph
# £
## POUND SIGN
### U+00A3


!SLIDE glyph
# ¥
## YEN SIGN
### U+00A5


!SLIDE glyph
# §
## SECTION SIGN
### U+00A7


!SLIDE glyph
# ¶
## PILCROW SIGN
### U+00B6


!SLIDE glyph
# ¼
## VULGAR FRACTION ONE QUARTER
### U+00BC


!SLIDE glyph
# ¿
## INVERTED QUESTION MARK
### U+00BF


!SLIDE glyph
# à
## LATIN SMALL LETTER A WITH GRAVE
### U+00E0


!SLIDE glyph
# á
## LATIN SMALL LETTER A WITH ACUTE
### U+00E1


!SLIDE glyph
# â
## LATIN SMALL LETTER A WITH CIRCUMFLEX
### U+00E2


!SLIDE glyph
# ã
## LATIN SMALL LETTER A WITH TILDE
### U+00E3


!SLIDE glyph
# ä
## LATIN SMALL LETTER A WITH DIAERESIS
### U+00E4


!SLIDE glyph
# å
## LATIN SMALL LETTER A WITH RING ABOVE
### U+00E5


!SLIDE glyph
# ā
## LATIN SMALL LETTER A WITH MACRON
### U+0101


!SLIDE glyph
# ă
## LATIN SMALL LETTER A WITH BREVE
### U+0103


!SLIDE glyph
# ą
## LATIN SMALL LETTER A WITH OGONEK
### U+0105


!SLIDE glyph
# ő
## LATIN SMALL LETTER O WITH DOUBLE ACUTE
### U+0151


!SLIDE glyph
# Ø
## LATIN CAPITAL LETTER O WITH STROKE
### U+00D8


!SLIDE glyph
# Ħ
## LATIN CAPITAL LETTER H WITH STROKE
### U+0126


!SLIDE glyph
# ŧ
## LATIN SMALL LETTER T WITH STROKE
### U+0167


!SLIDE glyph
# Ŀ
## LATIN CAPITAL LETTER L WITH MIDDLE DOT
### U+013F


!SLIDE glyph
# ď
## LATIN SMALL LETTER D WITH CARON
### U+010F


!SLIDE glyph
# Ǭ
## CAPITAL LETTER O WITH OGONEK AND MACRON
### U+01EC


!SLIDE glyph
# ı
## LATIN SMALL LETTER DOTLESS I
### U+0131


!SLIDE glyph
# ß
## LATIN SMALL LETTER SHARP S
### U+00DF


!SLIDE glyph
# Æ
## LATIN CAPITAL LETTER AE
### U+00C6


!SLIDE glyph
# ĳ
## LATIN SMALL LIGATURE IJ
### U+0133


!SLIDE glyph
# ﬃ
## LATIN SMALL LIGATURE FFI
### U+FB03


!SLIDE glyph
# ᵺ
## LATIN SMALL LETTER TH WITH STRIKETHROUGH
### U+1D7A


!SLIDE glyph
# Ð
## LATIN CAPITAL LETTER ETH
### U+00D0


!SLIDE glyph
# ð
## LATIN SMALL LETTER ETH
### U+00F0


!SLIDE glyph
# Þ
## LATIN CAPITAL LETTER THORN
### U+00DE


!SLIDE glyph
# ĸ
## LATIN SMALL LETTER KRA
### U+0138


!SLIDE glyph
# ŋ
## LATIN SMALL LETTER ENG
### U+014B


!SLIDE glyph
# ʤ
## LATIN SMALL LETTER DEZH DIGRAPH
### U+02A4


!SLIDE glyph
# Ψ
## GREEK CAPITAL LETTER PSI
### U+03A8


!SLIDE glyph
# Ὢ
## GREEK CAPITAL LETTER OMEGA WITH PSILI AND VARIA AND PROSGEGRAMMENI
### U+1FAA


!SLIDE glyph
# й
## CYRILLIC SMALL LETTER SHORT I
### U+0439


!SLIDE glyph
# Ѩ
## CYRILLIC CAPITAL LETTER IOTIFIED LITTLE YUS
### U+0468


!SLIDE glyph
# Ք
## ARMENIAN CAPITAL LETTER KEH
### U+0554


!SLIDE glyph
# ש
## HEBREW LETTER SHIN
### U+05E9


!SLIDE glyph
# س
## ARABIC LETTER SEEN
### U+0633


!SLIDE glyph
# ش
## ARABIC LETTER SHEEN
### U+0634


!SLIDE glyph
# ۞
## ARABIC START OF RUB EL HIZB
### U+06DE


!SLIDE glyph
# ܞ
## SYRIAC LETTER YUDH HE
### U+071E


!SLIDE glyph
# ޠ
## THAANA LETTER TO
### U+07A0


!SLIDE glyph
# ߢ
## NKO LETTER NYA
### U+07E2


!SLIDE glyph
# ऒ
## DEVANAGARI LETTER SHORT O
### U+0912


!SLIDE glyph
# ফ
## BENGALI LETTER PHA
### U+09AB


!SLIDE glyph
# ੴ
## GURMUKHI EK ONKAR
### U+0A74


!SLIDE glyph
# ઔ
## GUJARATI LETTER AU
### U+0A94


!SLIDE glyph
# ଈ
## ORIYA LETTER II
### U+0B08


!SLIDE glyph
# ஔ
## TAMIL LETTER AU
### U+0B94


!SLIDE glyph
# ఊ
## TELUGU LETTER UU
### U+0C0A


!SLIDE glyph
# ಫ
## KANNADA LETTER PHA
### U+0CAB


!SLIDE glyph
# ഌ
## MALAYALAM LETTER VOCALIC L
### U+0D0C


!SLIDE glyph
# ණ
## SINHALA LETTER MUURDHAJA NAYANNA
### U+0DAB


!SLIDE glyph
# ส
## THAI CHARACTER SO SUA
### U+0E2A


!SLIDE glyph
# ໖
## LAO DIGIT SIX
### U+0ED6


!SLIDE glyph
# ჱ
## GEORGIAN LETTER HE
### U+10F1


!SLIDE glyph
# ሑ
## ETHIOPIC SYLLABLE HHU
### U+1211


!SLIDE glyph
# ፼
## ETHIOPIC NUMBER TEN THOUSAND
### U+137C


!SLIDE glyph
# Ꮉ
## CHEROKEE LETTER MA
### U+13B9


!SLIDE glyph
# ᐛ
## CANADIAN SYLLABICS NASKAPI WAA
### U+141B


!SLIDE glyph
# ᙞ
## CANADIAN SYLLABICS CARRIER TSEE
### U+165E


!SLIDE glyph
# ᚙ
## OGHAM LETTER EAMHANCHOLL
### U+1699


!SLIDE glyph
# ᛤ
## RUNIC LETTER CEALC
### U+16E4


!SLIDE glyph
# ᜮ
## HANUNOO LETTER LA
### U+172E


!SLIDE glyph
# ឤ
## KHMER INDEPENDENT VOWEL QAA
### U+17A4


!SLIDE glyph
# ᨒ
## BUGINESE LETTER LA
### U+1A12


!SLIDE glyph
# ‰
## PER MILLE SIGN
### U+2030


!SLIDE glyph
# ℋ
## SCRIPT CAPITAL H
### U+210B


!SLIDE glyph
# ℂ
## DOUBLE-STRUCK CAPITAL C
### U+2102


!SLIDE glyph
# ℍ
## DOUBLE-STRUCK CAPITAL H
### U+210D


!SLIDE glyph
# ℝ
## DOUBLE-STRUCK CAPITAL R
### U+211D


!SLIDE glyph
# ⅗
## VULGAR FRACTION THREE FIFTHS
### U+2157


!SLIDE glyph
# ⅷ
## SMALL ROMAN NUMERAL EIGHT
### U+2177


!SLIDE glyph
# ⇇
## LEFTWARDS PAIRED ARROWS
### U+21C7


!SLIDE glyph
# ∉
## NOT AN ELEMENT OF
### U+2209


!SLIDE glyph
# ∰
## VOLUME INTEGRAL
### U+2230


!SLIDE glyph
# ⊮
## DOES NOT FORCE
### U+22AE


!SLIDE glyph
# ⌬
## BENZENE RING
### U+232C


!SLIDE glyph
# ⒄
## PARENTHESIZED NUMBER SEVENTEEN
### U+2484


!SLIDE glyph
# ⒘
## NUMBER SEVENTEEN FULL STOP
### U+2498


!SLIDE glyph
# Ⓠ
## CIRCLED LATIN CAPITAL LETTER Q
### U+24C6


!SLIDE glyph
# ╠
## BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
### U+2560


!SLIDE glyph
# ☀
## BLACK SUN WITH RAYS
### U+2600


!SLIDE glyph
# ☁
## CLOUD
### U+2601


!SLIDE glyph
# ☂
## UMBRELLA
### U+2602


!SLIDE glyph
# ☃
## SNOWMAN
### U+2603


!SLIDE glyph
# ☄
## COMET
### U+2604


!SLIDE glyph
# ☤
## CADUCEUS
### U+2624


!SLIDE glyph
# ☭
## HAMMER AND SICKLE
### U+262D


!SLIDE glyph
# ♍
## VIRGO
### U+264D


!SLIDE glyph
# ♞
## BLACK CHESS KNIGHT
### U+265E


!SLIDE glyph
# ✂
## BLACK SCISSORS
### U+2702


!SLIDE glyph
# ✈
## AIRPLANE
### U+2708


!SLIDE glyph
# ⟺
## LONG LEFT RIGHT DOUBLE ARROW
### U+27FA


!SLIDE glyph
# ⠓
## BRAILLE PATTERN DOTS-125
### U+2813


!SLIDE glyph
# ⥵
## RIGHTWARDS ARROW ABOVE ALMOST EQUAL TO
### U+2975


!SLIDE glyph
# Ⰼ
## GLAGOLITIC CAPITAL LETTER DJERVI
### U+2C0C


!SLIDE glyph
# Ⲝ
## COPTIC CAPITAL LETTER KSI
### U+2C9C


!SLIDE glyph
# ⵞ
## TIFINAGH LETTER YACH
### U+2D5E


!SLIDE glyph
# ⽉
## KANGXI RADICAL MOON
### U+2F49


!SLIDE glyph
# ち
## HIRAGANA LETTER TI
### U+3061


!SLIDE glyph
# ゲ
## KATAKANA LETTER GE
### U+30B2


!SLIDE glyph
# ㄆ
## BOPOMOFO LETTER P
### U+3106


!SLIDE glyph
# ㆈ
## HANGUL LETTER YO-YAE
### U+3188


!SLIDE glyph
# ㎓
## SQUARE GHZ
### U+3393


!SLIDE glyph
# 㖨
## HAN CHARACTER 'INDISTINCT NASAL UTTERANCE, LAUGH, SOUND OF BIRDS'
### U+35A8


!SLIDE glyph
# 豚
## HAN CHARACTER 'SMALL PIG, SUCKLING PIG'
### U+8C5A


!SLIDE glyph
# 黙
## HAN CHARACTER 'SILENT; QUIET, STILL; DARK' 
### U+9ED9


!SLIDE glyph
# ꕅ
## VAI SYLLABLE GI
### U+A545


!SLIDE title
# The SMP
## Supplementary Multilingual Plane
## `U+10000` to `U+1FFFF`


!SLIDE glyph
# 𐌸
## GOTHIC LETTER THIUTH
### U+10338


!SLIDE glyph
# 𐎌
## UGARITIC LETTER SHIN
### U+1033C


!SLIDE glyph
# 𐏈
## OLD PERSIAN SIGN AURAMAZDAA
### U+103C8


!SLIDE glyph
# 𐒁
## OSMANYA LETTER BA
### U+10481


!SLIDE glyph
# 𝀫
## BYZANTINE MUSICAL SYMBOL SYNAGMA META STAVROU
### U+1D02B


!SLIDE glyph
# 𝄤
## MUSICAL SYMBOL F CLEF OTTAVA BASSA
### U+1D124


!SLIDE glyph
# 𝌨
## TETRAGRAM FOR GATHERING
### U+1D328


!SLIDE glyph
# 𝒫
## MATHEMATICAL SCRIPT CAPITAL P
### U+1D4AB


!SLIDE glyph
# 😱
## FACE SCREAMING IN FEAR
### U+1F631


!SLIDE title
# Combining characters
## `U+0300` to `U+036F`


!SLIDE glyph
# ñ
## LATIN SMALL LETTER N WITH TILDE
### U+00F1


!SLIDE glyph
# ñ
## LATIN SMALL LETTER N
## COMBINING TILDE
### U+006E U+0303


!SLIDE

```
>> s = "an\u0303os"
=> "años"

>> s.size
=> 5

>> s.reverse
=> "sõna"
```


!SLIDE title
# Abugida
## or, ‘alphasyllabary’


!SLIDE title
# Tamil script
## `U+0B80` to `U+0BFF`


!SLIDE glyph
# ண
## TAMIL LETTER NNA
### U+0BA3


!SLIDE glyph
# ூ
## TAMIL VOWEL SIGN UU
### U+0BC2


!SLIDE glyph
# ணூ
### U+0BA3 U+0BC2


!SLIDE glyph
# ஶ
## TAMIL LETTER SHA
### U+0BB6


!SLIDE glyph
# ்
## TAMIL SIGN VIRAMA
### U+0BCD


!SLIDE glyph
# ர
## TAMIL LETTER RA
### U+0BB0


!SLIDE glyph
# ீ
## TAMIL VOWEL SIGN II
### U+0BC0


!SLIDE glyph
# ஶ்ரீ
## TAMIL SYLLABLE SHRII (śrī)
### U+0BB6 U+0BCD U+0BB0 U+0BC0


!SLIDE

```
>> s = "\u0BB6\u0BCD\u0BB0\u0BC0"
=> "ஶ்ரீ"

>> s.reverse
=> "ீர்ஶ"
```


!SLIDE glyph
# க
## TAMIL LETTER KA
### U+0B95


!SLIDE glyph
#ோ
## TAMIL VOWEL SIGN OO
### U+0BCB


!SLIDE glyph
# கோ
### U+0B95 U+0BCB
