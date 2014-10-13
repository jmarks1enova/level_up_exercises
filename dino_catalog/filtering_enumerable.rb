require "./filtered_enumerable"

# An Enumerable, queriable collection of objects that acts as factory for a
# filtered view of its items through a proxy interface to the underlying items'
# attributes.
module FilteringEnumerable
  include Enumerable

  # An unknown method is taken for a query condition against attributes of items
  def method_missing(attribute, *match_expressions)
    query(attribute
  end

  def respond_to_missing?(attribute, include_all)
    true
  end

  def query(attribute, *match_expressions)
    FilteredEnumerable.new(self, attribute, match_expressions)
  end
end
