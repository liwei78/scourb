module Scourb
  class OptionsException < StandardError
  end
  class FindException < OptionsException
  end
  class FileException < OptionsException
  end
  class DirException < OptionsException
  end
end