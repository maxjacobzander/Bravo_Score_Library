class ScoresController < ApplicationController
     
    get '/scores' do
        if logged_in?
            @scores = Score.all
            erb :"scores/index"
        else
            redirect "/login"
        end
    end

    get '/scores/new' do
        redirect_if_not_logged_in
        erb :"scores/new"
    end

    get '/scores/:id' do
        redirect_if_not_logged_in
        id = params[:id]
        @score = Score.find_by_id(id)
        erb :"scores/show"
    end

    post '/scores' do
        score = Score.new(params)
        if score.save
            redirect "scores/#{score.id}"
        else
            redirect "scores/new"
        end
    end

    get 'scores/:id/edit' do
        redirect_if_not_logged_in
        @users = User.all
        @score = Score.find_by_id(params[:id])
        if @score.user.id == current_user.id
            erb :"scores/edit"
        else
            redirect "/scores"
        end
    end

    patch 'scores/:id' do
        @score = Score.find_by_id(params[:id])
        params.delete("_method")
        if @score.update(params)
            redirect "scores/#{score.id}"
        else
            redirect "scores/new"
        end
    end

    delete 'scores/:id' do
        @score = Score.find_by_id(params[:id])
        if @score.user.id == current_user.id
            @score.destroy
        end
        redirect "/scores"
    end

end