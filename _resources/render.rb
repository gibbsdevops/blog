#!/usr/bin/env ruby

class Point
  attr_reader :x
  attr_reader :y
  def initialize(x, y)
    @x = x
    @y = y
  end
  def to_s
    [ @x, @y ].join ' '
  end
end

def p(x, y)
  Point.new(x, y)
end

class Polygon

  def initialize(args)
    @scale = args[:scale]
    @c = args[:start]
    @points = []
    @points.push @c

    # example of :code - l1 u2 d3
    # is the same as p.left(1), p.up(2), p.down(3)
    if args[:code]
      args[:code].split.each do |t|
        send(t[0], t[1..-1].to_i)
      end
    end
  end

  def up(n)
    @c = p(@c.x, @c.y - (n * @scale))
    @points.push @c
  end

  def down(n)
    @c = p(@c.x, @c.y + (n * @scale))
    @points.push @c
  end

  def left(n)
    @c = p(@c.x - (n * @scale), @c.y)
    @points.push @c
  end

  def right(n)
    @c = p(@c.x + (n * @scale), @c.y)
    @points.push @c
  end

  alias_method :u, :up
  alias_method :d, :down
  alias_method :l, :left
  alias_method :r, :right

  def to_s
    @points.join(', ')
  end

end

scale = 10

body_color = 'black'
body_highlight_color = '#555'
eye_color = 'black'
face_color_1 = '#e6c38d'
face_color_2 = '#f5e1bc'
belt_color_1 = '#aea218'
belt_color_2 = '#f7ee13'

puts '<?xml version="1.0" encoding="UTF-8"?>'
puts '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 220 290" preserveAspectRatio="xMidYMid meet" zoomAndPan="disable">'

puts '<!--<rect id="svgEditorBackground" x="0" y="0" width="220" height="290" style="fill: lightblue; stroke: black;" />-->'

# body
body = Polygon.new(
  start: p(10, 10), scale: scale,
  code: 'r1 u1 r2 d13 r4 u1 l1 u7 r1 u1 r8 d1 r1 d7 l1 d1 r2 u2 r1 u1 r2 d1 r1 d6 l1 d1 l4 d3 r1 d1 r1 d1 l1 d1 l1 d2 r1 d1 r1 d2 l7 u5 l4 d3 l7 u2 r1 u1 r2 u3 r1 u1 r2 u2 l6 u1 l1 u4 r1'
)
puts '<polygon points="' + body.to_s + '" fill="'+body_color+'" stroke="none"/>'

# sword
sword = Polygon.new(
  start: p(20, 10),
  scale: scale,
  code: 'r1 d12 l1',
)
puts '<polygon points="' + sword.to_s + '" fill="#dfdfdf" stroke="none"/>'

# face
puts '<rect x="90" y="70" width="60" height="30" fill="'+face_color_1+'" />'
puts '<rect x="100" y="90" width="20" height="10" fill="'+face_color_2+'" />'
puts '<rect x="130" y="90" width="20" height="10" fill="'+face_color_2+'" />'
puts '<rect x="100" y="80" width="10" height="10" fill="'+eye_color+'" stroke="'+eye_color+'" stroke-linejoin="round" />'
puts '<rect x="130" y="80" width="10" height="10" fill="'+eye_color+'" stroke="'+eye_color+'" stroke-linejoin="round" />'

# highlights
puts '<rect x="20" y="130" width="10" height="10" fill="'+body_highlight_color+'" />'
puts '<rect x="10" y="140" width="10" height="30" fill="'+body_highlight_color+'" />'
puts '<polygon points="' + Polygon.new(start: p(40, 150), scale: scale,
  code: 'u1 r4 u1 r1 u2 u5 r7 u1 l8 d6 r2 d1 r2 d1 l1 d1 l1 d1',
).to_s + '" fill="'+body_highlight_color+'" />'
puts '<polygon points="' + Polygon.new(start: p(150, 150), scale: scale,
  code: 'u1 r5 u2 r1 u1 l2 d2 l1 d2',
).to_s + '" fill="'+body_highlight_color+'" stroke="none"/>'
puts '<polygon points="' + Polygon.new(start: p(130, 250), scale: scale,
  code: 'r1 d1 r3 d1 l2 d1 l2',
).to_s + '" fill="'+body_highlight_color+'" stroke="none"/>'
puts '<polygon points="' + Polygon.new(start: p(20, 260), scale: scale,
  code: 'u1 r4 u3 r2 u1 r1 u4 l1 d3 l1 d1 l2 d3 l1 d2 l2',
).to_s + '" fill="'+body_highlight_color+'" stroke="none"/>'

# belt
puts '<rect x="80" y="190" width="10" height="10" fill="'+belt_color_2+'" stroke="'+belt_color_2+'" stroke-linejoin="round" />'
puts '<rect x="90" y="190" width="40" height="10" fill="'+belt_color_1+'" />'
puts '<rect x="140" y="190" width="10" height="10" fill="'+belt_color_2+'" stroke="'+belt_color_2+'" stroke-linejoin="round" />'
puts '<rect x="150" y="200" width="10" height="10" fill="'+belt_color_1+'" />'
puts '<rect x="160" y="210" width="10" height="10" fill="'+belt_color_1+'" />'
puts '<rect x="170" y="220" width="10" height="10" fill="'+belt_color_1+'" />'

puts '</svg>'
