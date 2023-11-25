require 'rails_helper'

RSpec.describe Badge, type: :model do
    describe "validations" do
      it "is valid with valid attributes" do
        badge = FactoryBot.build(:badge)
        expect(badge).to be_valid
      end
    end

    describe 'checker' do
      let(:user) { FactoryBot.create(:user) }
      let(:art_piece1) { FactoryBot.create(:art_piece, address:"125 Spence St, College Station, TX 77843") }
      let(:art_piece2) { FactoryBot.create(:art_piece, address:"125 Spence St, College Station, TX 77843") }
      let(:art_piece3) { FactoryBot.create(:art_piece, address:"125 Spence St, College Station, TX 77843") }
      let(:badge1) { FactoryBot.create(:badge, name:"Badge S1", requirement:"1") }
      let(:badge3) { FactoryBot.create(:badge, name:"Badge S3", requirement:"3") }
      let(:badgeBAD) { FactoryBot.create(:badge, name:"Badge BAD", badge_type:"!!GOBBLEDYGOOK!!") }
        
      
      it 'returns the right default icon' do
        expect(badge1.get_icon().include?("default_badge.png")).to eq(true)
      end

      it 'returns the right attached icon' do
        badge1.photo.attach(io: File.open("./test/images/pipe.png"), filename: "pipe.png", content_type: "image/png")
        url = Rails.application.routes.url_helpers.rails_blob_url(badge1.get_icon, only_path: true)
        expect(url.include?('pipe.png')).to eq(true)
      end

      it 'removes the attached icon' do
        badge1.photo.attach(io: File.open("./test/images/pipe.png"), filename: "pipe.png", content_type: "image/png")
        badge1.remove_custom_icon
        expect(badge1.get_icon().include?("default_badge.png")).to eq(true)
      end
  
      it 'does not give badges incorrectly' do
        n = badge1.name # this line somehow forces badge to show up in Badge.all

        expect(Badge.check_all_badges(user).include?("Badge S1")).to eq(false)
      end
  
      it 'gives badge 1 after stamp' do
        n = badge1.name # this line somehow forces badge to show up in Badge.all

        user.set_stamp(art_piece1, true)
        expect(Badge.check_all_badges(user).include?("Badge S1")).to eq(true)
      end
  
      it 'does not gives badge 1 twice' do
        n = badge1.name # this line somehow forces badge to show up in Badge.all
        
        user.set_stamp(art_piece1, true)
        Badge.check_all_badges(user)
        expect(Badge.check_all_badges(user).include?("Badge S1")).to eq(false)
      end
  
      it 'indicates correct progress' do
        user.set_stamp(art_piece1, true)
        user.set_stamp(art_piece2, true)
        expect(badge3.get_progress(user)).to eq("2/3")
      end
  
      it 'indicates completed progress' do
        n = badge1.name # this line somehow forces badge to show up in Badge.all

        user.set_stamp(art_piece1, true)
        Badge.check_all_badges(user)
        expect(badge1.get_progress(user)).to eq("COMPLETE")
      end
  
      it 'catches unknown badge type' do
        expect(badgeBAD.get_progress(user)).to eq("unknown (misconfigured badge type!)")
      end
  
      it 'will not complete unknown badge type' do
        expect(badgeBAD.will_complete(user)).to eq(false)
      end

    end
end
  