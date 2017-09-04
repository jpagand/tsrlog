require "thread"

def env
  envs = {
    "development" => "development",
    "staging" => "staging",
    "production" => "production",
    "d" => "development",
    "s" => "staging",
    "p" => "production",
  }
  unless envs.key?(ARGV.first)
    STDERR.puts(<<-EOS)
Usage: logit [#{envs.join('|')}]
    EOS
    exit 1
  end
  envs.fetch(ARGV[0])
end

file_name = "logs_#{env}.log"

Thread.new do
  `heroku logs -t -r #{env} >> "#{file_name}"; say fail`
end

seen_lines = {}

loop do
  print "> "
  input = STDIN.gets.chomp

  case input
  when ""
  when "exit"
    exit 0
  when "failed", "fail", "f"
    log_lines = File.read(file_name).lines.map(&:chomp)

    new_lines = log_lines.select { |line| seen_lines[line].nil? }
    puts new_lines.grep(/completed [^2]/i)

    log_lines.each { |log_line| seen_lines[log_line] = true }
  else
    puts `cat "#{file_name}" | ag "#{input}"`
  end
end
