require "ruby2d"

class MandelbrotJob
  include Ruby2D::DSL

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

  def create_tile(columns, rows, width, height)
    tiles = []
    columns.times do |column|
      rows.times do |row|
        tiles << {
          x_start: column * (width / columns),
          x_end: width * (column + 1) / columns,
          y_start: row * (height / rows),
          y_end: height * (row + 1) / rows
        }
      end
    end
    return tiles
  end

  def perform(settings)
    width = settings[:width]
    height = settings[:height]

    set(
      title: "Fractal",
      width: width, 
      height: height,
      background: "black"
    )

    canvas = Canvas.new(
      width: width, 
      height: height,
      x: 0,
      y: 0,
      fill: "white",
      update: false
    )

    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

   tiles = create_tile(3, 3, width, height)

    tiles.each do |tile|
      (tile[:y_start]...tile[:y_end]).each do |row|
        (tile[:x_start]...tile[:x_end]).each do |column|
          real = -2.0 + column * 3.0 / (width - 1)
          imaginary = 1.0 - row * 2.0 / (height - 1)

          point = Complex(real, imaginary)
          cnt = escape_count(point, settings[:max_iterations])
          color = cnt == settings[:max_iterations] ? "black" : "white"
          
          canvas.fill_rectangle(
            x: column,
            y: row,
            width: 1,
            height: 1,
            color: color 
          )
        end
      end
    end

  end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  elapsed_time = end_time - start_time

  puts "#{width}×#{height}\nmax_iterations: #{settings[:max_iterations]}\n処理時間: #{elapsed_time}秒"

    canvas.update
    show
  end
end