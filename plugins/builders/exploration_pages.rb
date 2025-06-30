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
            <% if item.content_type == "photo" %>
              <div
                data-scroll-highlight-target="item"
                class="
                  flex-none h-full <%= item.direction == 'portrait' ? 'aspect-[4/5]' : 'aspect-[5/4]' %> bg-white rounded-lg
                  shadow-md snap-center overflow-hidden
                "
              >
                <div
                  class="relative w-full h-full bg-gray-200"
                  data-controller="lazy-image"
                  data-lazy-image-src-value="<%= item.url %>"
                >
                  <!-- Placeholder -->
                  <div
                    class="
                      absolute inset-0 flex items-center justify-center transition-opacity
                      duration-500 data-[loading]:opacity-100 data-[loaded]:opacity-0
                    "
                    data-lazy-image-target="placeholder"
                  >
                    <svg class="w-12 h-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" 
                            d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                    </svg>
                  </div>
                  <!-- Image -->
                  <img
                    alt="Caxitlán <%= item.id %>"
                    class="
                      w-full h-full object-cover opacity-0 transition-opacity duration-[2s] ease-out
                      absolute inset-0 select-none no-drag
                    "
                    loading="lazy"
                    data-lazy-image-target="image"
                  />
                  <!-- Shimmer -->
                  <div class="loading-shimmer absolute inset-0 pointer-events-none"></div>
                  <!-- Overlay -->
                  <div class="absolute inset-0 z-10" data-lazy-image-target="overlay"></div>
                </div>
              </div>
            <% elsif item.content_type == "space" %>
              <div
                data-scroll-highlight-target="item"
                class="
                  flex-none h-full <%= item.direction == 'portrait' ? 'aspect-[4/5]' : 'aspect-[5/4]' %> snap-center
                "
              >
                <!-- Empty space -->
              </div>
            <% end %>
          <% end %>
        ERB
      end
    end
  end
end
