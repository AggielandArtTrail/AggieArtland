class UserStamps < ApplicationRecord

    validates :users_id, presence: true
    validates :art_pieces_id, presence: true

    def self.entry_exists?(user_id, art_piece_id)
        exists?(users_id: user_id, art_pieces_id: art_piece_id)
    end

    def self.find_by_user_id(user_id)
        where(users_id: user_id)
    end

end