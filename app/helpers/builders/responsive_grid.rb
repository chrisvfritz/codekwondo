# Helper class for dynamically building responsive_grid elements on the page. Simplifies
# a lot of the ceremony in building up all the divs and classes.
class Builders::ResponsiveGrid

  DEFAULT_ITEMS_PER_ROW = 3
  MAX_GRID_COLUMNS = 12

  attr_reader :template
  delegate :capture, :content_tag, to: :template

  # @overload initialize( collection, options, &block )
  def initialize( collection, options={}, template, &block )
    options[:xs] ||= options[:sm] ||= options[:md] ||= options[:lg] ||= DEFAULT_ITEMS_PER_ROW

    @collection = collection
    @options    = options
    @block      = block
    @template   = template
  end

  def render
    options = @options.merge class: "responsive-grid #{@options[:class]}"

    content_tag :div, options.except(:lg, :md, :sm, :xs) do
      content_tag :div, rendered_grid_items, class: 'row'
    end
  end

private

  def rendered_grid_items
    @collection.map do |item|
      content_tag :div, capture( item, &@block ), class: "grid-item #{responsive_columns}"
    end.join.html_safe
  end

  def responsive_columns
    columns = ''

    %i{lg md sm xs}.each do |size|
      columns += case @options[size]
      when 1,2,3,4,6,12 then "col-#{size}-#{MAX_GRID_COLUMNS / @options[size]} "
      else                   "col-#{size}-#{@options[size]}ths "
      end
    end

    columns
  end

end