module Terminology
	module Utils
		def self.identify
			require 'sys/proctable'
			proc_table = Sys::ProcTable.ps
			by_pid = proc_table.inject({}) do |r, p|
				r[p.pid] = p
				r
			end
			
			result = []
			current = by_pid[Process.pid]
			while current do
				result << current
				current = by_pid[current.ppid]
			end

			os = RbConfig::CONFIG['host_os']

			case os
			when 'linux-gnu'
				os_version = '0.0.0'
				terminal = result.map(&:cmdline)[2]
				terminal_version = '0.0.0'
				[os,os_version,terminal,terminal_version] # would be nice to be return host_os, host_os version, terminal name and terminal version
			when 'ming-w32'
				os_version = '0.0.0'
				terminal = result
				terminal_version = '0.0.0'
				[os,os_version,terminal,terminal_version] # would be nice to be return host_os, host_os version, terminal name and terminal version	
			when 'apple'
				#Apple OS
			else

			end
		end
	end
end
