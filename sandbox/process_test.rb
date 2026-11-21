require "rbconfig"
require "json"

command = [RbConfig.ruby, "lib/mini_worker.rb"]

settings_a = { 
  width: 600,
  height: 401,
  max_iterations: 100,
  tile_column: 2,
  tile_row: 2,
  tile_id: 1
}

settings_b = { 
  width: 600,
  height: 401,
  max_iterations: 100,
  tile_column: 2,
  tile_row: 2,
  tile_id: 2
}

settings_c = { 
  width: 600,
  height: 401,
  max_iterations: 100,
  tile_column: 2,
  tile_row: 2,
  tile_id: 3
}

settings_d = { 
  width: 600,
  height: 401,
  max_iterations: 100,
  tile_column: 2,
  tile_row: 2,
  tile_id: 4
}

render_settings = {
  width: 600,
  height: 401,
  max_iterations: 100,
  tiles: []
}

text_a = JSON.generate(settings_a)
text_b = JSON.generate(settings_b)
text_c = JSON.generate(settings_c)
text_d = JSON.generate(settings_d)

calc_a = IO.popen(command, "r+")
calc_b = IO.popen(command, "r+")
calc_c = IO.popen(command, "r+")
calc_d = IO.popen(command, "r+")

calc_a.puts("MandelCalcJob")
calc_a.puts(text_a)
calc_a.flush
calc_b.puts("MandelCalcJob")
calc_b.puts(text_b)
calc_b.flush
calc_c.puts("MandelCalcJob")
calc_c.puts(text_c)
calc_c.flush
calc_d.puts("MandelCalcJob")
calc_d.puts(text_d)
calc_d.flush

result_a = JSON.parse(calc_a.read, symbolize_names: true)
result_b = JSON.parse(calc_b.read, symbolize_names: true)
result_c = JSON.parse(calc_c.read, symbolize_names: true)
result_d = JSON.parse(calc_d.read, symbolize_names: true)

calc_a.close
calc_b.close
calc_c.close
calc_d.close

render_settings[:tiles] << result_a
render_settings[:tiles] << result_b
render_settings[:tiles] << result_c
render_settings[:tiles] << result_d
render_settings_json = JSON.generate(render_settings)

render = IO.popen(command, "r+")

render.puts("MandelRenderJob")
render.puts(render_settings_json)
render.flush

render.close

start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed_time = end_time - start_time
