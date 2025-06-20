module Dashboard
  class UploadCsvController < ApplicationController
    def new
    end

    def create
      file = params[:file]
      result = Dashboard::UploadCsv.call(file)

      if result
        redirect_to dashboard_upload_path, notice: 'Upload realizado com sucesso!'
      else
        redirect_to dashboard_upload_path, alert: 'Erro no upload. Verifique o arquivo.'
      end
    end
  end
end
