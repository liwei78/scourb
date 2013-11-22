require 'helper'

class TestCoward < Test::Unit::TestCase

  attrs = {:find => 'gost', :file => 'gost', :dir => 'gost'}

  context "validate attrs" do
    subject { Scourb::Coward.new(attrs) }
    should "have attr" do
      subject.respond_to?(:dir)
      subject.respond_to?(:file)
      subject.respond_to?(:find)
      assert_equal '*', subject.ext
    end
  end

  context "opt ext" do
    subject { Scourb::Coward.new(attrs.merge({ext: 'html'})) }
    should "have attr" do
      assert_equal 'html', subject.ext
    end
  end

  context "call without options" do

    should "raise dir error" do
      assert_raise Scourb::DirException do
        Scourb::Coward.new(attrs.merge(dir: nil))
      end
    end

    should "raise file error" do
      assert_raise Scourb::FileException do
        Scourb::Coward.new(attrs.merge(file: nil))
      end
    end

    should "raise find error" do
      assert_raise Scourb::FindException do
        Scourb::Coward.new(attrs.merge(find: nil))
      end
    end

  end

  context "run with options" do
    setup do
      @coward = Scourb::Coward.new(attrs.merge(dir: '.'))
    end
    should '--dir get files' do
      # WHY ./Gemfile not found??
      assert @coward.get_files.include?('./README.md')
    end
  end

end
