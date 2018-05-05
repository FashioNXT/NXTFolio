class MockRedis
	def initialize()
		@dirname = "local_redis"
	end

	def _create_dir()
		unless File.directory?(@dirname)
			puts "creating dir"
			FileUtils.mkdir_p(@dirname)
		end
	end

	def set(name, content)
		_create_dir()
		File.open(File.join(@dirname, name), 'w') {
			|file| file.puts content
		}
	end

	def del(name)
		_create_dir()
		FileUtils.rm(File.join(@dirname, name))
	end

	def get(name)
		_create_dir()
		begin
			return File.read(File.join(@dirname, name))
		rescue
			return ""
		end
	end
end

if ENV["REDIS_URL"].nil? || ENV["REDIS_URL"].empty?
	$redis = MockRedis.new()
else
	$redis = Redis.new(url: ENV["REDIS_URL"])
end

