require 'rails_helper'

RSpec.describe AppSettings, type: :model do
  
    it 'exists as a singleton' do
      expect(AppSettings.instance).to_not eq(nil)
    end

    describe 'stamp icon' do
    
      it 'does not have attached file by default' do
        expect(AppSettings.instance.get_default_stamp_icon).to eq('https://aggie-art-public.s3.us-east-2.amazonaws.com/default_stamp.png')
      end
  
      it 'attaches file' do
        AppSettings.instance.default_stamp_icon.attach(io: File.open("./test/images/pipe.png"), filename: "pipe.png", content_type: "image/png")
        url = Rails.application.routes.url_helpers.rails_blob_url(AppSettings.instance.get_default_stamp_icon, only_path: true)
        expect(url.include?('pipe.png')).to eq(true)
      end
  
      it 'does not remove non-existent attachment' do
        expect(AppSettings.instance.remove_default_stamp_icon).to eq(false)
      end
  
      it 'removes attached file' do
        AppSettings.instance.default_stamp_icon.attach(io: File.open("./test/images/pipe.png"), filename: "pipe.png", content_type: "image/png")
        expect(AppSettings.instance.remove_default_stamp_icon).to eq(true)
      end

    end

    describe 'badge icon' do
    
      it 'does not have attached file by default' do
        expect(AppSettings.instance.get_default_badge_icon).to eq('https://aggie-art-public.s3.us-east-2.amazonaws.com/default_badge.png')
      end
  
      it 'attaches file' do
        AppSettings.instance.default_badge_icon.attach(io: File.open("./test/images/pipe.png"), filename: "pipe.png", content_type: "image/png")
        url = Rails.application.routes.url_helpers.rails_blob_url(AppSettings.instance.get_default_badge_icon, only_path: true)
        expect(url.include?('pipe.png')).to eq(true)
      end
  
      it 'does not remove non-existent attachment' do
        expect(AppSettings.instance.remove_default_badge_icon).to eq(false)
      end
  
      it 'removes attached file' do
        AppSettings.instance.default_badge_icon.attach(io: File.open("./test/images/pipe.png"), filename: "pipe.png", content_type: "image/png")
        expect(AppSettings.instance.remove_default_badge_icon).to eq(true)
      end

    end
end
  