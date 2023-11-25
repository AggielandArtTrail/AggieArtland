class AppSettings < ApplicationRecord
    # The "singleton_guard" column is a unique column which must always be set to '0'
    # This ensures that only one AppSettings row is created
    validates_inclusion_of :singleton_guard, :in => [0]
    has_one_attached :default_stamp_icon
    has_one_attached :default_badge_icon

    def self.instance
        first_or_create!(singleton_guard: 0)
    end

    def get_default_stamp_icon
        if self.default_stamp_icon.attached?
            self.default_stamp_icon
        else
            'https://aggie-art-public.s3.us-east-2.amazonaws.com/default_stamp.png'
        end
    end

    def get_default_badge_icon
        if self.default_badge_icon.attached?
            self.default_badge_icon
        else
            'https://aggie-art-public.s3.us-east-2.amazonaws.com/default_badge.png'
        end
    end

    def remove_default_stamp_icon
        if self.default_stamp_icon.attached?
            self.default_stamp_icon.purge
        end
    end

    def remove_default_badge_icon
        if self.default_badge_icon.attached?
            self.default_badge_icon.purge
        end
    end

end
