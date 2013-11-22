# encoding: utf-8
require 'iconv' if RUBY_VERSION < '1.9'

module Scourb

  class Coward

    attr_accessor :dir, :find, :ext, :reports, :charset

    def initialize(opt)

      raise FindException if opt[:find].nil?

      @find    = opt[:find]
      @dir     = opt[:dir]||Dir.pwd
      @ext     = opt[:ext]||'*'
      @charset = opt[:charset]
      @reports = []
      
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
      p @reports
      totaltime = Time.now - btime
      p "Take #{totaltime} sec."
      p "#{(totaltime / itemscount)*1000} ms/file"
    end

    private 
      def checkit(file)
        IO.foreach(file) do |line|
          str = line
          
          # http://www.redmine.org/projects/redmine/repository/revisions/11440/diff/trunk/lib/tasks/migrate_from_mantis.rake
          if @charset
            if RUBY_VERSION < '1.9'
              str = Iconv.iconv("UTF-8//IGNORE", "#{@charset.upcase}//IGNORE", line) 
            else
              str = line.to_s.force_encoding(@charset.upcase).encode('UTF-8')
            end
          end

          unless str.inspect.scan(@find).empty?
            @reports << file
            break
          end
        end
      end

  end
end