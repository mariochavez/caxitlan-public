class Builders::ExplorationPages < Bridgetown::Builder
  def build
    Bridgetown.logger.info "ExplorationPagesBuilder", "Builder is running..."
    hook :site, :post_read do
      Bridgetown.logger.info "ExplorationPagesBuilder", "Hook fired, generating pages..."
      generate_exploration_pages
    end
  end

  private

  def generate_exploration_pages
    exploration_names = %w[uno dos tres cuatro cinco seis siete ocho nueve diez]

    exploration_names.each_with_index do |name, index|
      # Skip if data file doesn't exist
      next unless site.data.exploraciones && site.data.exploraciones[name]

      # Create the resource using add_resource
      add_resource :pages, "exploracion-#{name}.html" do
        Bridgetown.logger.info "ExplorationPagesBuilder", "Creating page: exploracion-#{name}"
        layout :exploration
        title "Exploración #{name.capitalize} | Caxitlán"
        body_class "about-page bg-white"
        image "/images/caxitlan-cover.jpg"

        # Use _content_ for the actual content
        _content_ <<~ERB
          <% site.data.exploraciones.#{name}.items.each do |item| %>
            <%= render ExplorationItem.new(item: item) if item.content_type == "photo" %>
          <% end %>
        ERB
      end
    end
  end
end
