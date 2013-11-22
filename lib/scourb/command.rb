# encoding: utf-8

module Scourb
  class Command

    def self.grep(opt)
      coward = Coward.new(opt)
      coward.fight
    end

    protected

      def self.read_links
        @@links = IO.readlines(@@links_file)
      end

      def self.read_words
        @@words = IO.readlines(@@words_file)
      end
  end
end