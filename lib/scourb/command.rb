# encoding: utf-8

module Scourb
  class Command

    def self.grep(opt)
      coward = Coward.new(opt)
      coward.fight
      coward.savereport
    end

    protected

  end
end