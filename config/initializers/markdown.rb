global_markdown_extensions = {
  autolink: true,
  tables: true,
  fenced_code_blocks: true
}

global_html_renderer_options = {
  prettify: true
}

MARKDOWN = Redcarpet::Markdown.new(
  Redcarpet::Render::HTML.new(
    global_html_renderer_options.merge({
      filter_html: true,
      safe_links_only: true
    })
  ),
  global_markdown_extensions.merge({
    # nothing yet
  })
)

TRUSTED_MARKDOWN = Redcarpet::Markdown.new(
  Redcarpet::Render::HTML.new(
    global_html_renderer_options.merge({
      # nothing yet
    })
  ),
  global_markdown_extensions.merge({
    # nothing yet
  })
)