# encoding: utf-8

module Scourb
  class Command

    @@links_file = File.join('dict', 'links.txt')
    @@words_file = File.join('dict', 'words.txt')
    @@links = []
    @@words = []
    @@finds = []

    def self.grep(opt)
      read_words
      @@words.each do |word|
        system("grep -r '#{word.strip}' .")
      end
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