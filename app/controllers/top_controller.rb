class TopController < ActionController::Base
    def index 
    end
    def show
        @original_text = params[:query]
    end
end