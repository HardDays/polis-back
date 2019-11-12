module CalculationHelper

  def self.prev_calculate(params)
    response = RestClient.post Helper.api_url.to_s,
                                   {
                                       :vehicle          => params[:vehicle],
                                       :multidrive         =>  params[:multidrive],
                                       :exactCalculation   =>  params[:exactCalculation],
                                       :drivers            =>  params[:drivers],
                                       :owner              =>  params[:owner],
                                       :usePeriod         =>  params[:usePeriod]
                                   }.to_json,
                                   {
                                       'Authorization':Helper.getINGURUToken.to_s,
                                       'Content-Type':'application/json'
                                   }
    result = {}
    result[:calculations] = JSON.parse(response.body)

    
    result[:data] = SaverHelper.save_full_agreement(params)

    return result
  end

  def self.full_calculate(params)

    response = RestClient::Request.execute(method: :post,
                                           url:  Helper.api_url.to_s,
                                           payload: {
                                                     :sk               => params[:sk],
                                                     :vehicle          => {
                                                         :type         =>  params[:vehicle][:type],
                                                         :power        =>  params[:vehicle][:power],
                                                         :year         =>  params[:vehicle][:year],
                                                         :vin          =>  params[:vehicle][:vin],
                                                         :docType      =>  params[:vehicle][:docType],
                                                         :docSerial    =>  params[:vehicle][:docSerial],
                                                         :docNumber    =>  params[:vehicle][:docNumber],
                                                         :docDate      =>  params[:vehicle][:docDate],
                                                         :brand        =>  params[:vehicle][:brand],
                                                         :model        =>  params[:vehicle][:model],
                                                         :dc           =>  params[:vehicle][:dc],
                                                         :dcDate       =>  params[:vehicle][:dcDate],
                                                         :dcIssueDate  =>  params[:vehicle][:dcIssueDate]
                                                     },
                                                     :multidrive         =>  params[:multidrive],
                                                     :drivers            =>  params[:drivers],
                                                     :owner              =>  {
                                                         :lastname       =>  params[:owner][:lastname],
                                                         :firstname      =>  params[:owner][:firstname],
                                                         :middlename     =>  params[:owner][:middlename],
                                                         :birthdate      =>  params[:owner][:birthdate],
                                                         :passportSerial =>  params[:owner][:passportSerial],
                                                         :passportNumber =>  params[:owner][:passportNumber],
                                                         :name           =>  params[:owner][:name],
                                                         :inn            =>  params[:owner][:inn],
                                                         :docSerial      =>  params[:owner][:docSerial],
                                                         :docNumber      =>  params[:owner][:docNumber],
                                                         :city           =>  params[:owner][:city],
                                                         :street         =>  params[:owner][:street],
                                                         :house          =>  params[:owner][:house],
                                                         :apartment      =>  params[:owner][:apartment],
                                                         :fullkladr      =>  params[:owner][:fullkladr],
                                                         :zip            =>  params[:owner][:zip],
                                                         :fullAddress    =>  params[:owner][:fullAddress]
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
                                           headers: {
                                               'Authorization': Helper.getINGURUToken.to_s,
                                               'Content-Type':'application/json'
                                                  },
                                           timeout: 120)
     # response = RestClient.post Helper.api_url.to_s,
     #                               {
     #                                   :sk               => params[:sk],
     #                                   :vehicle          => {
     #                                       :type         =>  params[:vehicle][:type],
     #                                       :power        =>  params[:vehicle][:power],
     #                                       :year         =>  params[:vehicle][:year],
     #                                       :vin          =>  params[:vehicle][:vin],
     #                                       :docType      =>  params[:vehicle][:docType],
     #                                       :docSerial    =>  params[:vehicle][:docSerial],
     #                                       :docNumber    =>  params[:vehicle][:docNumber],
     #                                       :docDate      =>  params[:vehicle][:docDate],
     #                                       :brand        =>  params[:vehicle][:brand],
     #                                       :model        =>  params[:vehicle][:model],
     #                                       :dc           =>  params[:vehicle][:dc],
     #                                       :dcDate       =>  params[:vehicle][:dcDate],
     #                                       :dcIssueDate  =>  params[:vehicle][:dcIssueDate]
     #                                   },
     #                                   :multidrive         =>  params[:multidrive],
     #                                   :drivers            =>  params[:drivers],
     #                                   :owner              =>  {
     #                                       :lastname       =>  params[:owner][:lastname],
     #                                       :firstname      =>  params[:owner][:firstname],
     #                                       :middlename     =>  params[:owner][:middlename],
     #                                       :birthdate      =>  params[:owner][:birthdate],
     #                                       :passportSerial =>  params[:owner][:passportSerial],
     #                                       :passportNumber =>  params[:owner][:passportNumber],
     #                                       :name           =>  params[:owner][:name],
     #                                       :inn            =>  params[:owner][:inn],
     #                                       :docSerial      =>  params[:owner][:docSerial],
     #                                       :docNumber      =>  params[:owner][:docNumber],
     #                                       :city           =>  params[:owner][:city],
     #                                       :street         =>  params[:owner][:street],
     #                                       :house          =>  params[:owner][:house],
     #                                       :apartment      =>  params[:owner][:apartment],
     #                                       :fullkladr      =>  params[:owner][:fullkladr],
     #                                       :zip            =>  params[:owner][:zip],
     #                                       :fullAddress    =>  params[:owner][:fullAddress]
     #                                   },
     #                                   :usePeriod         =>  params[:usePeriod],
     #                                   :insurerIsOwner    =>  params[:insurerIsOwner],
     #                                   :purpose           =>  params[:purpose],
     #                                   :licensePlate      =>  params[:licensePlate],
     #                                   :registeredAbroad  =>  params[:registeredAbroad],
     #                                   :registrationWay   =>  params[:registrationWay],
     #                                   :useTrailer        =>  params[:useTrailer],
     #                                   :violations        =>  params[:violations],
     #                                   :date              =>  params[:date],
     #                                   :phone             =>  params[:phone],
     #                                   :email             =>  params[:email],
     #                                   :name              =>  params[:name]
     #                               }.to_json,
     #                               {
     #                                   'Authorization': Helper.getINGURUToken.to_s,
     #                                   'Content-Type':'application/json'
     #                               }
    return response.body
  end

  def self.full_calculate_vs_ins(params)

    response = RestClient::Request.execute(method: :post,
                                           url:  Helper.api_url.to_s,
                                           payload: {
                                               :sk               => params[:sk],
                                               :vehicle          => {
                                                   :type         =>  params[:vehicle][:type],
                                                   :power        =>  params[:vehicle][:power],
                                                   :year         =>  params[:vehicle][:year],
                                                   :vin          =>  params[:vehicle][:vin],
                                                   :docType      =>  params[:vehicle][:docType],
                                                   :docSerial    =>  params[:vehicle][:docSerial],
                                                   :docNumber    =>  params[:vehicle][:docNumber],
                                                   :docDate      =>  params[:vehicle][:docDate],
                                                   :brand        =>  params[:vehicle][:brand],
                                                   :model        =>  params[:vehicle][:model],
                                                   :dc           =>  params[:vehicle][:dc],
                                                   :dcDate       =>  params[:vehicle][:dcDate],
                                                   :dcIssueDate  =>  params[:vehicle][:dcIssueDate]
                                               },
                                               :multidrive         =>  params[:multidrive],
                                               :drivers            =>  params[:drivers],
                                               :owner              =>  {
                                                   :lastname       =>  params[:owner][:lastname],
                                                   :firstname      =>  params[:owner][:firstname],
                                                   :middlename     =>  params[:owner][:middlename],
                                                   :birthdate      =>  params[:owner][:birthdate],
                                                   :passportSerial =>  params[:owner][:passportSerial],
                                                   :passportNumber =>  params[:owner][:passportNumber],
                                                   :name           =>  params[:owner][:name],
                                                   :inn            =>  params[:owner][:inn],
                                                   :docSerial      =>  params[:owner][:docSerial],
                                                   :docNumber      =>  params[:owner][:docNumber],
                                                   :city           =>  params[:owner][:city],
                                                   :street         =>  params[:owner][:street],
                                                   :house          =>  params[:owner][:house],
                                                   :apartment      =>  params[:owner][:apartment],
                                                   :fullkladr      =>  params[:owner][:fullkladr],
                                                   :zip            =>  params[:owner][:zip],
                                                   :fullAddress    =>  params[:owner][:fullAddress]
                                               },
                                               :usePeriod         =>  params[:usePeriod],
                                               :insurerIsOwner    =>  params[:insurerIsOwner],
                                               :insurer              =>  {
                                                   :lastname       =>  params[:insurer][:lastname],
                                                   :firstname      =>  params[:insurer][:firstname],
                                                   :middlename     =>  params[:insurer][:middlename],
                                                   :birthdate      =>  params[:insurer][:birthdate],
                                                   :passportSerial =>  params[:insurer][:passportSerial],
                                                   :passportNumber =>  params[:insurer][:passportNumber],
                                                   :city           =>  params[:insurer][:city],
                                                   :street         =>  params[:insurer][:street],
                                                   :house          =>  params[:insurer][:house],
                                                   :apartment      =>  params[:insurer][:apartment],
                                                   :fullkladr      =>  params[:insurer][:fullkladr],
                                                   :zip            =>  params[:insurer][:zip],
                                                   :fullAddress    =>  params[:insurer][:fullAddress]
                                               },
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
                                           headers: {
                                               'Authorization': Helper.getINGURUToken.to_s,
                                               'Content-Type':'application/json'
                                           },
                                           timeout: 120)
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
