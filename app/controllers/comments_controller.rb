class CommentsController < ApplicationController

  def create
    @topic = Topic.find( params[:topic_id] )
    @post = @topic.posts.find( params[:post_id] )
    @comments = @post.comments

    @comment = current_user.comments.build( comment_params )
    @comment.post = @post
    @new_comment = Comment.new

    authorize @comment

    if @comment.save
      flash[:notice] = "Comment was created."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
    end

    redirect_to :back
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find([:id])

    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      # redirect_to [@topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Please try again."
      # redirect_to [@topic, @post]
    end

    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
