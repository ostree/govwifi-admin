class SuperAdmin::MouController < SuperAdminController
  def index
    @mou = AdminConfig.mou
  end

  def create
    if params[:id]
      organisation = Organisation.find(params[:id])
      attach_to_organisation(organisation)
      redirect_to super_admin_organisation_path(organisation)
    else
      attach_to_template
    end
  end

private

  def attach_to_organisation(organisation)
    if params[:signed_mou]
      if params[:signed_mou].content_type == "application/pdf"
        organisation.signed_mou.attach(params[:signed_mou])
        flash[:notice] = "MOU uploaded successfully."
      else
        flash[:alert] = "Unsupported file type. Signed MOU should be a PDF."
      end
    else
      flash[:alert] = "No MoU file selected. Please select a file and try again."
    end
  end

  def attach_to_template
    if params[:unsigned_document]
      if params[:signed_mou].content_type == "application/pdf"
        AdminConfig.mou.unsigned_document.attach(params[:unsigned_document])
        flash[:notice] = "MOU template uploaded successfully."
      else
        flash[:alert] = "Unsupported file type. MOU template should be a PDF."
      end
    else
      flash[:alert] = "No MoU template selected. Please select a file and try again."
    end
    redirect_to super_admin_mou_index_path
  end
end
