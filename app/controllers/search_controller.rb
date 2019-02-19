class SearchController < ApplicationController
  PAGE_SIZE = 30
  def index
    if search_params[:question].present?
      @current_page = (search_params[:page] || 1).to_i

      search_client = Search.client
      search_options = {
        page: {
          current: @current_page,
          size: PAGE_SIZE,
        },
      }

      search_response = search_client.search(Search::ENGINE_NAME, search_params[:question], search_options)
      @total_pages = search_response['meta']['page']['total_pages']
      result_ids = search_response['results'].map { |rg| rg['id']['raw'].to_i }

      @articles = Article.where(id: result_ids).sort_by { |rg| result_ids.index(rg.id) }
    end
  end

  private

    def search_params
      params.permit(:question, :page)
    end
end
