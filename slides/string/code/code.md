!SLIDE

```
                  ©   ->  Â©


                  ü   ->  Ã¼


                  ಫ   ->  à²«
```


!SLIDE

```
        © = U+00A9  = C2 A9 (UTF-8)

        in win-1252, C2 = Â, A9 = ©


        ü = U+00FC  = C3 BC (UTF-8)

        in win-1252, C3 = Ã, BC = ¼


        ಫ = U+0CAB  = E0 B2 AB (UTF-8)
        
        in win-1252, E0 = à, B2 = ², AB = «
```


!SLIDE title
# Ruby


!SLIDE

```
>> "ℝ"
=> "ℝ"

>> "\u211D"
=> "ℝ"

>> "\xE2\x84\x9D"
=> "ℝ"

>> 0x61.chr
=> "a"

>> 0x211D.chr
RangeError: 8477 out of char range
```


!SLIDE

```
>> "\u0061"
=> "a"

>> "\u61"
SyntaxError: (irb):13: invalid Unicode escape
>> "\u{61}"
=> "a"

>> "\u1D124"
=> "ᴒ4"           # == "\u1D12" + "4"
>> "\u{1D124}"
=> "𝄤"
```


!SLIDE

```
>> string = "ℝ"

>> string.size            # => 1

>> string.chars           # => ["ℝ"]

>> hex string.codepoints  # => <211D>

>> string.encoding        # => #<Encoding:UTF-8>

>> string.bytesize        # => 3

>> hex string.bytes       # => <E2 84 9D>
```


!SLIDE

```
>> s = "ℝ"
>> [hex(s), s.encoding, hex(s.bytes)]
=> [<U+211D>, #<Encoding:UTF-8>, <E2 84 9D>]

>> s = s.encode("utf-16be")
>> [hex(s), s.encoding, hex(s.bytes)]
=> [<U+211D>, #<Encoding:UTF-16BE>, <21 1D>]

>> s = s.encode("utf-16")
>> [hex(s), s.encoding, hex(s.bytes)]
=> [<U+FEFF U+211D>, #<Encoding:UTF-16 (dummy)>,
    <FE FF 21 1D>]
```


!SLIDE

```
>> s = s.encode("windows-1252")

Encoding::UndefinedConversionError:
    U+211D to WINDOWS-1252 in conversion
    from UTF-8 to WINDOWS-1252
```


!SLIDE

```
>> s = "\xFE\xFF\x21\x1D"

>> s.valid_encoding?
=> false

>> s.codepoints
ArgumentError: invalid byte sequence in UTF-8

>> [s.encoding, hex(s.bytes)]
=> [#<Encoding:UTF-8>, "<FE FF 21 1D>"]
```


!SLIDE

```
>> s.force_encoding("utf-16")

>> s.valid_encoding?
=> true

>> s.codepoints
=> [65279, 8477]

>> [hex(s), s.encoding, hex(s.bytes)]
=> [<U+FEFF U+211D>, #<Encoding:UTF-16 (dummy)>,
    <FE FF 21 1D>]
```


!SLIDE

```
>> s = [0xE2, 0x88, 0xB0].pack("c*")
=> "\xE2\x88\xB0"

>> [hex(s), s.encoding, hex(s.bytes)]
=> [<U+00E2 U+0088 U+00B0>,
    #<Encoding:ASCII-8BIT>, <E2 88 B0>]

>> s.force_encoding("utf-8")
=> "∰"

>> [hex(s), s.encoding, hex(s.bytes)]
=> [<U+2230>, #<Encoding:UTF-8>, <E2 88 B0>]
```


!SLIDE

```
>> s = "😱"
>> [hex(s), s.encoding, hex(s.bytes)]
=> [<U+1F631>, #<Encoding:UTF-8>, <F0 9F 98 B1>]

>> t = "∉".encode("utf-16be")
>> [hex(t), t.encoding, hex(t.bytes)]
=> [<U+2209>, #<Encoding:UTF-16BE>, <22 09>]

>> s + t
Encoding::CompatibilityError: incompatible
    character encodings: UTF-8 and UTF-16BE

>> t + s
Encoding::CompatibilityError: incompatible
    character encodings: UTF-16BE and UTF-8
```


!SLIDE

```
>> v = s + t.encode("utf-8")
=> "😱∉"

>> [hex(v), v.encoding, hex(v.bytes)]
=> [<U+1F631 U+2209>, #<Encoding:UTF-8>,
    <F0 9F 98 B1 E2 88 89>]

>> v = s + t.dup.force_encoding("utf-8")
=> "😱\"\t"

>> [hex(v), v.encoding, hex(v.bytes)]
=> [<U+1F631 U+0022 U+0009>, #<Encoding:UTF-8>,
    <F0 9F 98 B1 22 09>]
```


!SLIDE

```
>> s = "s"
>> t = "t".force_encoding("ascii-8bit")

>> (s + t).encoding
=> #<Encoding:UTF-8>

>> (t + s).encoding
=> #<Encoding:ASCII-8BIT>
```


!SLIDE

```
>> s = "s"
>> t = "©".force_encoding("ascii-8bit")

>> (s + t).encoding
=> #<Encoding:ASCII-8BIT>

>> (t + s).encoding
=> #<Encoding:ASCII-8BIT>
```


!SLIDE

```
>> "\u211D".encoding
=> #<Encoding:UTF-8>

>> File.read("index.html")
=> #<Encoding:UTF-8>

>> File.read("vt100.jpg")
=> #<Encoding:UTF-8>
```


!SLIDE

```
>> File.read("index.html").encoding
=> #<Encoding:UTF-8>

>> Encoding.default_external = "utf-16be"

>> File.read("index.html").encoding
ArgumentError: ASCII incompatible encoding
               needs binmode
```


!SLIDE title
# HTML and HTTP


!SLIDE

```txt
    HTTP/1.1 200 OK
    Content-Type: text/html; charset=utf-8

    <!doctype html>
    <html>
      <head>
        <meta charset="utf-8">
        ...
```


!SLIDE

```
      ℝ       &#8477;     &#x211D;
```


!SLIDE

```
    ”     &rdquo;   &#8221;   &#x201D;
```


!SLIDE

```
                <     &lt;

                &     &amp;

                "     &quot;

                '     &#39;
```


!SLIDE

```
>> ERB::Util.h '&'
=> "&amp;"
>> ERB::Util.h '"'
=> "&quot;"
>> ERB::Util.h '<'
=> "&lt;"

>> ERB::Util.h '”'
=> "”"
>> ERB::Util.h 'ℝ'
=> "ℝ"
```


!SLIDE

```txt
    <form method="post" action="/login">
      <label for="username">Name:</label>
      <input type="text" name="username">
      <input type="submit" value="Go">
    </form>
```


!SLIDE

```
        +-------------------+   +----+
Name:   | ℝ                 |   | Go |
        +-------------------+   +----+
```


!SLIDE

```
post "/login" do
  body = request.body.read
  # "username=%E2%84%9D" <Encoding:ASCII-8BIT>

  type = env["CONTENT_TYPE"]
  # "application/x-www-form-urlencoded"
end

>> username = CGI.unescape("%E2%84%9D")
=> "ℝ"

>> username.encoding
=> #<Encoding:UTF-8>
```


!SLIDE title
# JavaScript


!SLIDE

```
> moon = "\u2F49"
'⽉'

> moon.length
1

> moon = "\xE2\xBD\x89"
'â½'

> moon.length
3
```


!SLIDE

```
> face = "😱"
'😱'

> face.length
2

> [face.charAt(0), face.charAt(1)]
[ '�', '�' ]

> cs = [face.charCodeAt(0), face.charCodeAt(1)]
[ 55357, 56881 ]

> cs.map(function(c) { return c.toString(16) })
[ 'd83d', 'de31' ]
```


!SLIDE

```
> codepoint = ((cs[0] - 0xD800) << 10) +
              (cs[1] - 0xDC00) +
              0x10000

> codepoint.toString(16)
'1f631'

// U+1F631 = 😱
```


!SLIDE

```
> face.match(/./g)
[ '�', '�' ]

> face.match(/../g)
[ '😱' ]
```
