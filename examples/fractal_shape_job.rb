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
    tile_id = 1
    columns.times do |column|
      rows.times do |row|
        tiles << {
          tile_id: tile_id,
          x_start: column * (width / columns),
          x_end: width * (column + 1) / columns,
          y_start: row * (height / rows),
          y_end: height * (row + 1) / rows
        }
        tile_id += 1
      end
    end
    return tiles
  end

  def calc_tile(tile, width, height, max_iterations)
    escape_counts = []
    (tile[:y_start]...tile[:y_end]).each do |row|
      ch_escape_counts = []
        (tile[:x_start]...tile[:x_end]).each do |column|
          real = -2.0 + column * 3.0 / (width - 1)
          imaginary = 1.0 - row * 2.0 / (height - 1)
          point = Complex(real, imaginary)
          cnt = escape_count(point, max_iterations)
          ch_escape_counts.push(cnt)
        end
        escape_counts.push(ch_escape_counts)
      end
    return {
      tile_id: tile[:tile_id],
      escape_counts: escape_counts
    }
  end

  def draw_tile(tile, tile_result, max_iterations, canvas)
    tile_result[:escape_counts].each_with_index do |row, row_cnt|
      row.each_with_index do |column, column_cnt|
        color = column == max_iterations ? "black" : "white"
              
        canvas.fill_rectangle(
          x: tile[:x_start] + column_cnt,
          y: tile[:y_start] + row_cnt,
          width: 1,
          height: 1,
          color: color 
        )
      end
    end
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
      result = calc_tile(tile, width, height, settings[:max_iterations])
      draw_tile(tile, result, settings[:max_iterations], canvas)
    end      
    

    end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed_time = end_time - start_time

    puts "#{width}×#{height}\nmax_iterations: #{settings[:max_iterations]}\n処理時間: #{elapsed_time}秒"

    canvas.update
    show
  end
end