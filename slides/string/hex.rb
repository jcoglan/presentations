def hex(data, digits = 2)
  case data
  when String
    points = data.codepoints.map { |p| 'U+' + hex(p, 4) }
    '<' + points.join(' ') + '>'
  when Array
    bytes = data.map { |b| hex(b, digits) }
    '<' + bytes.join(' ') + '>'
  else
    data.to_s(16).rjust(digits, '0').upcase
  end
end
