module EncodingUtils
  module_function

  ENCODING     = 'UTF-8'.freeze
  REPLACE_CHAR = ' '.freeze

  def replace_unknown_bytes(string)
    string.encode(ENCODING, invalid: :replace, undef: :replace, replace: REPLACE_CHAR)
  end
end
