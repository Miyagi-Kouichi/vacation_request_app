class CommentsController < ApplicationController

     def create
          @comment = current_user.comments.new(comment_params)
          if @comment.save!
            redirect_back(fallback_location: root_path)
          else
            redirect_back(fallback_location: root_path) 
          end
        end
      
        private
        def comment_params
          params.require(:comment).permit(:comment_content).merge(holiday_id: params[:holiday_id])
        end
end
