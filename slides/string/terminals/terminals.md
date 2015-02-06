!SLIDE title
# Your terminal
## is lying to you


!SLIDE

![](vt100.jpg)

[DEC VT100
terminal](http://commons.wikimedia.org/wiki/File:DEC_VT100_terminal.jpg#mediaviewer/File:DEC_VT100_terminal.jpg)
by Jason Scott - Flickr: IMG_9976. Licensed under CC BY 2.0 via Wikimedia
Commons


!SLIDE

> ESC is 0x1b. Down arrow is 0x1b,0x5b,0x42. Both start with 0x1b. Terminal apps
> differentiate by waiting ~250ms and peeking at the next byte.
>
> – [Gary Bernhardt](https://twitter.com/garybernhardt/status/554783868352335873)


!SLIDE

```
>> Encoding.default_external
=> #<Encoding:UTF-8>

>> scream = "😱"
=> "😱"

>> scream.force_encoding("windows-1252")
=> "\xF0\x9F\x98\xB1"

>> Encoding.default_external = "windows-1252"

>> scream
=> "x9F\x98±"
>> scream.force_encoding("utf-8")
=> "\u{1F631}"
```


!SLIDE

```
def hex(data, digits = 2)
  case data
  when String
    cp = data.codepoints
    points = cp.map { |p| 'U+' + hex(p, 4) }
    '<' + points.join(' ') + '>'
  when Array
    bytes = data.map { |b| hex(b, digits) }
    '<' + bytes.join(' ') + '>'
  else
    data.to_s(16).rjust(digits, '0').upcase
  end
end
```


!SLIDE

```
>> scream = "me: 😱"
=> "me: 😱"

>> hex scream
=> <U+006D U+0065 U+003A U+0020 U+1F631>

>> hex scream.bytes
=> <6D 65 3A 20 F0 9F 98 B1>
```


!SLIDE glyph
# 😱


!SLIDE glyph
# ðŸ˜±


!SLIDE

```
>> scream = "😱"
=> "😱"

>> hex scream
=> <U+1F631>

>> hex scream.bytes
=> <F0 9F 98 B1>
```


!SLIDE

```
>> scream.force_encoding("windows-1252")
=> "\xF0\x9F\x98\xB1"

>> hex scream
=> <U+00F0 U+009F U+0098 U+00B1>

>> hex scream.bytes
=> <F0 9F 98 B1>
```


!SLIDE

```
>> scream = scream.encode("utf-8")
=> "ðŸ˜±"

>> hex scream
=> <U+00F0 U+0178 U+02DC U+00B1>

>> hex scream.bytes
=> <C3 B0 C5 B8 CB 9C C2 B1>
```

