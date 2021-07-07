class VisitsController < ApplicationController
    def list_by_id
        @visits = Visit.all()
        @post = Post.find(params["format"].to_i)
       # @post = Post.find(params[:format][:id.to_i])
    end
end