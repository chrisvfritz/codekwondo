class StackoverflowController < ApplicationController

  def tags
    respond_to do |format|
      format.json do
        render(json: [].to_json) and return unless params[:query].present?

        tags = Rails.cache.fetch("stackoverflow_tags: {params: #{params}, pagesize: 10, version: 1}", expires_in: 1.week) do
          RubyStackoverflow.tags(inname: params[:query], pagesize: 10).data.map do |tag|
            {
              value: tag.name,
              text: tag.name
            }
          end.to_json
        end

        render json: tags
      end
    end
  end

end
