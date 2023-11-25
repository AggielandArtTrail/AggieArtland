class AppSettingsController < ApplicationController
  
  def edit
    @app_settings = AppSettings.instance
  end

  def update
    @app_settings = AppSettings.instance
    respond_to do |format|
      if @app_settings.update(app_settings_params)
        format.html { redirect_to app_setting_path, notice: "App settings were successfully updated." }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @app_settings.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_default_stamp_icon
    AppSettings.instance.remove_default_stamp_icon
    redirect_to app_setting_path
  end

  def remove_default_badge_icon
    AppSettings.instance.remove_default_badge_icon
    redirect_to app_setting_path
  end

  private
    # Only allow a list of trusted parameters through.
    def app_settings_params
      params.require(:app_settings).permit(:default_stamp_icon, :default_badge_icon)
    end
end
