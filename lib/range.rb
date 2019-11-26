class Range
  def equivalent_to?(other)
    (min <=> other.min).zero? && (max <=> other.max).zero?
  end
end
