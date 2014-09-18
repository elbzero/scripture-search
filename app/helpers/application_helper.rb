module ApplicationHelper

  def highlight_search( text )
    highlight( text, params[:search],  highlighter: '<div class="highlight">\1</div>' )
  end 
end
