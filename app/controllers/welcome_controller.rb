class WelcomeController < ApplicationController
  def index
    # 単純なjsonを返す
    render json: { message: 'Hello, World!' }
  end
end
