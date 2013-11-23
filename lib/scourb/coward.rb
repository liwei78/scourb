# encoding: utf-8
require 'iconv' if RUBY_VERSION < '1.9'

module Scourb

  class Coward

    attr_accessor :dir, :find, :ext, :reports, :charset, :reportname

    def initialize(opt)

      raise FindException if opt[:find].nil?

      @find    = opt[:find]
      @dir     = opt[:dir]||Dir.pwd
      @ext     = opt[:ext]||'*'
      @charset = opt[:charset]
      @reports = []
      @reportname = opt[:report]||'report'
      
    end

    def get_files
      Dir.glob(File.join(@dir, '**', "*.#{ext}"))
    end

    def fight
      btime = Time.now
      files = get_files
      itemscount = files.length
      bloop = files.length
      # bloop = 10
      while bloop > 0
        file = files.shift
        checkit(file) unless file.nil?
        bloop -= 1
      end
      p "*" * 30
      totaltime = Time.now - btime
      p "Found #{@reports.length}." unless @reports.empty?
      p "Take #{totaltime} sec."
      p "#{(totaltime / itemscount)*1000} ms/file"
    end

    def savereport
      File.open("#{@reportname}.txt", "w") do |file|
        @reports.each do |line|
          file.write(line)
        end
      end unless @reports.empty?
    end

    private 
      def checkit(file)
        IO.foreach(file) do |line|
          
          # http://www.redmine.org/projects/redmine/repository/revisions/11440/diff/trunk/lib/tasks/migrate_from_mantis.rake
          if @charset
            if RUBY_VERSION < '1.9'
              str = Iconv.iconv("UTF-8//IGNORE", "#{@charset.upcase}//IGNORE", line) 
            else
              str = line.to_s.force_encoding(@charset.upcase).encode('UTF-8')
            end
          else
            str = line
          end

          unless str.inspect.scan(@find).empty?
            @reports << file
            break
          end
        end
      end

  end
end