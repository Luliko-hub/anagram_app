class TopController < ActionController::Base
    def index 
    end
    def show
        @original_txt = params[:query]
        anagram = Anagram.new
        @anagram_txt = anagram.local_search_base(@original_txt, 10)
    end
end