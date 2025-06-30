module ExplorationHelpers
  EXPLORATION_NAMES = %w[uno dos tres cuatro cinco seis siete ocho nueve diez].freeze

  def exploration_data(number)
    site.data.exploraciones[EXPLORATION_NAMES[number - 1]]
  end

  def exploration_number_from_name(name)
    EXPLORATION_NAMES.index(name) + 1 if EXPLORATION_NAMES.include?(name)
  end

  def exploration_title(name)
    exploration_number_from_name(name)
    "Exploración #{name.capitalize} | Caxitlán"
  end
end

Bridgetown::RubyTemplateView::Helpers.include ExplorationHelpers
