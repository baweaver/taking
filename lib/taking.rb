require "taking/version"

# Quick helpers for deriving pattern-matchable entities from lists of arguments
# passed in via `...`. See README for more examples
#
# @author baweaver
# @since 0.0.1
#
module Taking
  MATCH_METHODS = %i(deconstruct deconstruct_keys)

  # Unfolds arguments dynamically.
  #
  # @param lead [#deconstruct, #deconstruct_keys]
  #   Optional object which responds to pattern matching
  #
  # @param *args [Array[Any]]
  #   Array-style arguments
  #
  # @param *kwargs [Hash[Symbol, Any]]
  #   Keyword arguments
  #
  # @return [Any]
  #   If the lead object is deconstructable, return that first
  #
  # @return [Array[Any]]
  #   If not, amend the lead to the other args
  #
  # @return [Hash[Symbol, Any]]
  #   and if KWARGS are present, return those instead
  def self.from(lead = nil, *args, **kwargs)
    if args.empty? && kwargs.empty?
      return can_deconstruct?(lead) ? lead : nil
    end

    kwargs.empty? ? [lead, *args] : kwargs
  end

  # Unfolds Array arguments
  #
  # @param *args [Array[Any]]
  #
  # @return [Array[Any]]
  def self.from_list(*args) = args

  # Unfolds Keyword arguments
  #
  # @param **args [Hash[Any, Any]]
  #
  # @return [Hash[Any, Any]]
  def self.from_kw(**args) = args

  # Checks if an object can deconstruct
  #
  # @param o [Any]
  #
  # @return [Boolean]
  def self.can_deconstruct?(o)
    MATCH_METHODS.any? { o.respond_to?(_1) }
  end
end
