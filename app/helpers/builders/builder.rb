# Common functionality shared by all builders
class Builders::Builder
  attr_reader  :template
  delegate :capture, :content_tag, to: :template

  def initialize( options, template, &block )
    @options  = options || {}
    @template = template
    @block    = block
  end

  def self.content_method( *names )
    names.each do |name|
      class_eval %{
        def #{name}( content = nil, &block )
          @#{name} = content || capture( &block )
          nil
        end

        def #{name}?; @#{name} end

        def render_#{name}
          @#{name} && content_tag( :div, @#{name}, class: "\#{css_name}_#{name}" )
        end
      }, __FILE__, __LINE__ + 1
    end
  end

  # Renders the builder
  def render
    klass   = @options[:class] || ""
    options = @options.merge class: "#{css_name} #{builder_classes} #{klass}"

    content_tag :div, render_options( options ) do
      # Must invoke here to allow nested blocks to run and capture child content.
      body = @block && capture( self, &@block )
      html_join render_heading, render_body( body ), render_footer
    end
  end

  private

    def render_heading; end
    def render_footer; end

    def render_body( rendered_body )
      content_tag( :div, class: "#{css_name}_body" ) do
        format_body( rendered_body )
      end
    end

    def format_body( rendered_body )
      rendered_body
    end

    def render_options( options )
      options
    end

    def css_name
      @css_name ||= "n" + self.class.name.demodulize.underscore.downcase
    end

    def html_join( *segments )
      segments.compact.reduce("".html_safe) do |html,segment|
        html + segment
      end
    end

end