require 'rails_helper'

RSpec.describe UserStamps, type: :model do
  describe '.entry_exists?' do
    it 'returns true if the entry exists' do
      user_id = 1
      art_piece_id = 42
      UserStamps.create(users_id: user_id, art_pieces_id: art_piece_id)

      expect(UserStamps.entry_exists?(user_id, art_piece_id)).to be_truthy
    end

    it 'returns false if the entry does not exist' do
      expect(UserStamps.entry_exists?(1, 42)).to be_falsey
    end
  end

  describe '.find_by_user_id' do
    it 'returns user stamps for the given user_id' do
      user_id = 1
      art_piece_id = 42
      UserStamps.create(users_id: user_id, art_pieces_id: art_piece_id)

      expect(UserStamps.find_by_user_id(user_id).count).to eq(1)
    end

    it 'returns an empty array if no user stamps are found' do
      expect(UserStamps.find_by_user_id(1)).to be_empty
    end
  end
end
