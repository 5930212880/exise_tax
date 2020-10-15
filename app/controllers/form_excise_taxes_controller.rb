require 'rest-client'
require 'json'

class FormExciseTaxesController < ApplicationController
  before_action :find_by_formreferencenumber, only: [:save_form_product_source, :inquiry_form_product_checklist_sou, :inquiry_form_product_checklist_des]
  skip_before_action :verify_authenticity_token, only: [:save_form_product_source, :inquiry_form_product_checklist_sou, :inquiry_form_product_checklist_des]


  def new
    # @form_excise_tax = FormExciseTax.new
  end

  # GET /excisetaxes
  # GET /excisetaxes.json
  def index
    @form_excise_taxes = FormExciseTax.all
  end

  # GET /excisetaxes/formeffectivedate
  def inquiry
    url = params[:formeffectivedate]
    
    data = RestClient.post 'http://webtest.excise.go.th/EDRestServicesUAT/rtn/InquiryPs0501',{
       SystemId:"systemid", 
       UserName:"my_username", 
       Password:"bbbbb", 
       IpAddress:"10.11.1.10", 
       Operation:"1", 
       RequestData: {
        FormReferenceNumber: "", 
        FormEffectiveDateFrom: "", 
        FormEffectiveDateTo: "", 
        HomeOfficeId: "",
        FormStatus: "A", 
        FormUpdateDate:"#{url}", 
        ProductCategory:"01"
       } 
     }.to_json, 
     {
       content_type: :json
     }
    
    if JSON.parse(data)['ResponseCode'] != "OK"
      render json: { status: 404, error: "Not Found" }, status: :not_found
    else
    #parse json
      api_data = JSON.parse(data)['ResponseData']['FormInformation']['FormData']

    #map data to db
      api_data.each do |value|
          if FormExciseTax.exists?(['formreferencenumber LIKE ?',"%#{value['FormReferenceNumber']}%"])
            FormExciseTax.where(['formreferencenumber LIKE ?',"%#{value['FormReferenceNumber']}%"]).update(
                  cusname: value['CusName'],
                  formeffectivedate: value['FormEffectiveDate'],
                  formreferencenumber: value['FormReferenceNumber'],
                  signflag: value['SignFlag'],
                  formdata: value
              )
          else 
            FormExciseTax.create!(
                  cusname: value['CusName'],
                  formeffectivedate: value['FormEffectiveDate'],
                  formreferencenumber: value['FormReferenceNumber'],
                  signflag: value['SignFlag'],
                  formdata: value
              )
          end    
      end
      render json: FormExciseTax.all
    end
  end


  # POST /excisetaxes/saveproduct/[:formreferencenumber]
  def save_form_product_source #ส่งหมายเลขทะเบียนรถ/seal/maker

  if @formref.signflag == '2'
    @listcheck = @formref.formdata['GoodsListCheck']['GoodsEntry'].map do |v| 
      { UnitCode: v['UnitCode'], 
        Amount: v['SouAmount'], 
        SeqNo: v['SeqNo'], 
        TransportName: v['SouTransportName'], 
        SealNo: v['SouSealNo'], 
        SealAmount: v['SouSealAmount'], 
        Marker: v['SouMarker'], 
        GoodsInformation: { 
          ProductCode: v['ProductCode'], 
          CategoryCode1: v['BrandMainCode'], 
          CategoryCode2: v['BrandSecondCode'], 
          CategoryCode3: v['ModelCode'], 
          CategoryCode4: v['SizeCode'], 
          CategoryCode5: v['DegreeCode']
        } 
      }
    end 

    @requestdata = { 
      SystemId: "systemid",
      UserName: "my_username",
      Password: "bbbbb",
      IpAddress: "10.11.1.10",
      Operation: "1",
      RequestData: { FormCode: "PS28",
      FormReferenceNumber: @formref.formreferencenumber,
      FormEffectiveDate: @formref.formeffectivedate.strftime('%Y%m%d'),
      OffCode: @formref.formdata['HomeOfficeId'],
      TransFrom: "1",
      Remark: "",
      GoodsList: {
        GoodsEntry: @listcheck
      }
      } 
    }.to_json

    # saveproduct = RestClient.post 'http://webtest.excise.go.th/EDRestServicesUAT/rtn/SaveFormProductSource', 
    #   @requestdata, { content_type: :json }
    
    render json: @requestdata

  else
    render json: { ResponseMessage: 'ไม่สามารถบันทึกข้อมูลได้' } 
  end
end

  # POST /excisetaxes/inquirychecklistsou/[:formreferencenumber] 
  def inquiry_form_product_checklist_sou #ดึงรายชื่อผู้เซ็น ต้นทาง signflag = 4  
    # formref = FormDatum.find_by(formreferencenumber: params[:formreferencenumber])

    @productchecklistsou = {
      SystemId: "systemid",
      UserName: "my_username",
      Password: "bbbbb",
      IpAddress: "10.11.1.10",
      Operation: "1",
      RequestData: { FormCode: "PS28",
      FormReferenceNumber: @formref.formreferencenumber,
      FormEffectiveDate: @formref.formeffectivedate.strftime('%Y%m%d'),
      OffCode: @formref.formdata['HomeOfficeId'],
      ActionType: "1"
      }
    }.to_json

    inquiryformchecklistsou = RestClient.post 'http://webtest.excise.go.th/EDRestServicesUAT/rtn/InquiryFormProductCheckList',
      @productchecklistsou, { content_type: :json }

    render json: inquiryformchecklistsou
  end

  # POST /excisetaxes/inquirychecklistdes/[:formreferencenumber] 
  def inquiry_form_product_checklist_des #ดึงรายชื่อผู้เซ็น ปลายทาง signflag = 2  
    # checklist = FormDatum.find_by(formreferencenumber: params[:formreferencenumber])

    @productchecklistdes = {
      SystemId: "systemid",
      UserName: "my_username",
      Password: "bbbbb",
      IpAddress: "10.11.1.10",
      Operation: "1",
      RequestData: { FormCode: "PS28",
      FormReferenceNumber: @formref.formreferencenumber,
      FormEffectiveDate: @formref.formeffectivedate.strftime('%Y%m%d'),
      OffCode: @formref.data['HomeOfficeId'],
      ActionType: "2"
      }
    }.to_json

    inquiryformchecklistdes = RestClient.post 'http://webtest.excise.go.th/EDRestServicesUAT/rtn/InquiryFormProductCheckList',
      @productchecklistdes, { content_type: :json }

    render json: inquiryformchecklistdes
  end

  # # GET /form_excise_taxes/new
  # def new
  #   @form_excise_tax = FormExciseTax.new
  # end

  # # GET /form_excise_taxes/1/edit
  # def edit
  # end

  # # POST /form_excise_taxes
  # # POST /form_excise_taxes.json
  # def create
  #   @form_excise_tax = FormExciseTax.new(form_excise_tax_params)

  #   respond_to do |format|
  #     if @form_excise_tax.save
  #       format.html { redirect_to @form_excise_tax, notice: 'Form excise tax was successfully created.' }
  #       format.json { render :show, status: :created, location: @form_excise_tax }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @form_excise_tax.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /form_excise_taxes/1
  # # PATCH/PUT /form_excise_taxes/1.json
  # def update
  #   respond_to do |format|
  #     if @form_excise_tax.update(form_excise_tax_params)
  #       format.html { redirect_to @form_excise_tax, notice: 'Form excise tax was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @form_excise_tax }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @form_excise_tax.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /form_excise_taxes/1
  # # DELETE /form_excise_taxes/1.json
  # def destroy
  #   @form_excise_tax.destroy
  #   respond_to do |format|
  #     format.html { redirect_to form_excise_taxes_url, notice: 'Form excise tax was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_form_excise_tax
  #     @form_excise_tax = FormExciseTax.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def form_excise_tax_params
  #     params.require(:form_excise_tax).permit(:formreferencenumber, :formeffectivedate, :cusname, :signflag, :formdata)
  #   end

  private
    def find_by_formreferencenumber
      @formref = FormExciseTax.find_by(formreferencenumber: params[:formreferencenumber])
    end

end
