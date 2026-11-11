require "ruby2d"

set(
  title: "Fractal",
  width: 600, 
  height: 400,
  background: "black"
)

canvas = Canvas.new(
  width: 600, 
  height: 400,
  x: 0,
  y: 0,
  fill: "white",
  update: false
)

def escape_count(fixed_number, max_iterations)
  number = Complex(0, 0)
  cnt = 0

  max_iterations.times do
    cnt += 1
    number = number * number + fixed_number
    if number.abs > 2
      return cnt
    end
  end

  return max_iterations
end

width = 600
height = 400
height.times do |row|
  width.times do |column|
    real = -2.0 + column * 3.0 / (width - 1)
    imaginary = 1.0 - row * 2.0 / (height - 1)

    point = Complex(real, imaginary)
    cnt = escape_count(point, 100)
    if cnt == 100
      color = "black"
    elsif cnt <= 2
      color = "blue"
    elsif cnt <= 10
      color = "yellow"
    elsif cnt <= 50
      color = "red"
    else
      color = "white"
    end
      canvas.fill_rectangle(
        x: column,
        y: row,
        width: 1,
        height: 1,
        color: color 
      )
  end
end

canvas.update
show