module Api
    module V1
      class InguruController < ApplicationController
        
        def auth
          render json: {token: InguruHelper.token}, status: :ok
        end
  
        def full_calculate
          render json: InguruHelper.full_calculate(params), status: :ok
        end
  
        def offer
          render json: InguruHelper.offer(params[:sk], params[:agreement]), status: :ok
        end

        def regions
          render json: InguruHelper.regions(params[:regId], params[:distId])
        end
  
        def polis
          render json: InguruHelper.qeid(:document, params[:eId]) , status: :ok
        end        

        def pay_link
          render json: InguruHelper.qeid(:payurl, params[:eId]) , status: :ok
        end
 
        def pay_status
          render json: InguruHelper.qeid(:payment, params[:eId]) , status: :ok
        end
        
      end
    end
  end
  