module BuildersHelper
  def responsive_grid( collection, options={}, &block )
    Builders::ResponsiveGrid.new( collection, options, self, &block ).render
  end
end