require "active_support"

module Selector
  extend ActiveSupport::Concern

  SelectorError = Class.new(StandardError)
  SelectorExpressionError = Class.new(SelectorError)

  AVAILABLE_SELECTORS = Set.new

  included do
    AVAILABLE_SELECTORS << self

    def self.config_variable(*var_names)
      var_names.each do |var|
        define_method(var) { get_configuration(var) }
        define_method(:"#{var.to_s}=") { |val| set_configuration(var, val) }
      end
    end
  end

  def self.all_criteria
    AVAILABLE_SELECTORS.to_a
  end

  def self.create_selector_from_expression(expression)
    AVAILABLE_SELECTORS.each do |selector|
      try_create_selector(selector, expression) do |new_selector|
        return new_selector
      end
    end

    raise SelectorExpressionError, "Expression translation failure"
  end

  def self.try_create_selector(selector, expression)
    yield selector.parse_expression(expression)
  rescue
    # This expression does not apply to this selector
  end

  attr_reader :config_source

  def using_configuration_source(config_source)
    @config_source = config_source
    self
  end

  def parse_expression(expression)
    raise NotImplementedError,
          "#{self.class.name}::#{__method__}: including class must implement" 
  end

  def generate_sql(configuration)
    raise NotImplementedError,
          "#{self.class.name}::#{__method__}: including class must implement" 
  end

  protected

  def get_configuration(var_name)
    config_source.configuration[var_name.to_s]
  end

  def set_configuration(var_name, value)
    config_source.configuration[var_name.to_s] = value
  end
end

require "selector/comparator"
