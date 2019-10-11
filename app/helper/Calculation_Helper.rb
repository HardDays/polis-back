module CalculationHelper

  def self.prev_calculate(params)
    response = RestClient.post Helper.api_url.to_s,
                                   {
                                      :vehicle          => params[:vehicle],
                                      # {
                                      #                           :type         =>  params[:type],
                                      #                           :power        =>  params[:power],
                                      #                           :year         =>  params[:year]
                                      #                       },
                                     :multidrive         =>  params[:multidrive],
                                     :exactCalculation   =>  params[:exactCalculation],
                                     :drivers            =>  params[:drivers],
                                     :owner              =>  params[:owner]
                                    #  {
                                    #                           :city  =>  params[:city]
                                    #                         },
                                     :usePeriod         =>  params[:usePeriod]
                                   }.to_json,
                                   {
                                       'Authorization':Helper.getINGURUToken.to_s,
                                       'Content-Type':'application/json'
                                   }
    return response.body
  end

  def self.full_calculate(params)
     response = RestClient.post Helper.api_url.to_s,
                                   {
                                       :sk               => params[:sk],
                                       :vehicle          => {
                                           :type         =>  params[:type],
                                           :power        =>  params[:power],
                                           :year         =>  params[:year],
                                           :vin          =>  params[:vin],
                                           :docType      =>  params[:docType],
                                           :docSerial    =>  params[:docSerial],
                                           :docNumber    =>  params[:docNumber],
                                           :docDate      =>  params[:docDate],
                                           :brand        =>  params[:brand],
                                           :model        =>  params[:model],
                                           :dc           =>  params[:dc],
                                           :dcDate       =>  params[:dcDate],
                                           :dcIssueDate  =>  params[:dcIssueDate]
                                       },
                                       :multidrive         =>  params[:multidrive],
                                       :drivers            =>  params[:drivers],
                                       :owner              =>  {
                                           :lastname       =>  params[:owner_lastname],
                                           :firstname      =>  params[:owner_firstname],
                                           :middlename     =>  params[:owner_middlename],
                                           :birthdate      =>  params[:owner_birthdate],
                                           :passportSerial =>  params[:owner_passportSerial],
                                           :passportNumber =>  params[:owner_passportNumber],
                                           :city           =>  params[:owner_city],
                                           :street         =>  params[:owner_street],
                                           :house          =>  params[:owner_house],
                                           :apartment      =>  params[:owner_apartment],
                                           :fullkladr      =>  params[:owner_fullkladr],
                                           :zip            =>  params[:owner_zip],
                                           :fullAddress    =>  params[:owner_fullAddress]
                                       },
                                       :usePeriod         =>  params[:usePeriod],
                                       :insurerIsOwner    =>  params[:insurerIsOwner],
                                       :purpose           =>  params[:purpose],
                                       :licensePlate      =>  params[:licensePlate],
                                       :registeredAbroad  =>  params[:registeredAbroad],
                                       :registrationWay   =>  params[:registrationWay],
                                       :useTrailer        =>  params[:useTrailer],
                                       :violations        =>  params[:violations],
                                       :date              =>  params[:date],
                                       :phone             =>  params[:phone],
                                       :email             =>  params[:email],
                                       :name              =>  params[:name]
                                   }.to_json,
                                   {
                                       'Authorization':Helper.getINGURUToken.to_s,
                                       'Content-Type':'application/json'
                                   }
    return response.body
  end

  def self.pay_link(params)
    response = RestClient.get Helper.api_url.to_s,{'Authorization':Helper.getINGURUToken.to_s, 'Content-Type':'application/json', params:{q:'payurl', eId:params[:eId]}}
    return response.body
  end

  def self.pay_status(params)
    response = RestClient.get Helper.api_url.to_s,{'Authorization':Helper.getINGURUToken.to_s, 'Content-Type':'application/json', params:{q:'payment', eId:params[:eId]}}
    return response.body
  end

  def self.polis_doc(params)
    response = RestClient.get Helper.api_url.to_s,{'Authorization':Helper.getINGURUToken.to_s, 'Content-Type':'application/json', params:{q:'document', eId:params[:eId]}}
    return response.body
  end

end
