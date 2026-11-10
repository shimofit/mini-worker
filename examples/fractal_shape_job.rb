require "ruby2d"

set(
  title: "Fractal",
  width: 400, 
  height: 400,
  background: "black"
)

canvas = Canvas.new(
  width: 400, 
  height: 400,
  x: 0,
  y: 0,
  fill: "white"
)

3.times do |row|
  3.times do |column|
    if row == 1 && column == 1
      next
    end
    canvas.fill_rectangle(
      x: column * 100 + 50,
      y: row * 100 + 50,
      width: 100,
      height: 100,
      color: "red"
    )
  end
end


show