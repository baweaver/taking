require "taking/version"

module Taking
  # Unfolds Array arguments
  #
  # @param *args [Array[Any]]
  #
  # @return [Array[Any]]
  def self.from(*args)     = args

  # Unfolds Keyword arguments
  #
  # @param **args [Hash[Any, Any]]
  #
  # @return [Hash[Any, Any]]
  def self.from_kw(**args) = args
end
