def wordwrap(words, maxwidth)
  words.slice_before(cols: 0) do |w, h|
    h[:cols] += 1 if h[:cols] != 0

    p w, h
    h[:cols] += w.length

    if maxwidth < h[:cols]
      h[:cols] = w.length
      true
    else
      false
    end
  end
end
text = (1..4).to_a.join(" ")
enum = wordwrap(text.split(/\s+/), 10)
puts "-"*10
enum.each { |ws| puts ws.join(" ") }
puts "-"*10
