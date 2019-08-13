class Range
  def overlaps?(range)
    range.first <= range.last &&
      first <= last &&
      (cover?(range.first) || cover?(range.last) ||
       range.cover?(first) || range.cover?(last))
  end
end
