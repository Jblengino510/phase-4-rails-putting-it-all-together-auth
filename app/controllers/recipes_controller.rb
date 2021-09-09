class RecipesController < ApplicationController

    before_action :authorize

    def index
        render json: Recipe.all
    end

    def create
        recipe = find_user.recipes.create(recipe_params)
        if recipe.valid?
            render json: recipe, status: :created
        else
            render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def find_user
        User.find(session[:user_id])
    end

    def recipe_params
        params.permit(:user_id, :title, :instructions, :minutes_to_complete)
    end

    def authorize
        return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
    end
end
