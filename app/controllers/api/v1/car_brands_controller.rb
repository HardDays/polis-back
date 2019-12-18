module Api
    module V1
      class CarBrandsController < ApplicationController

        def index
          render json: CarBrand.all.order('created_at ASC')
        end
  
        def show
          render json: CarBrand.find(params[:id])
        end

      end
    end
  end
  
  