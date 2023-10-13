require 'faker'

FactoryBot.define do
    factory :user do
        email { Faker::Internet.email }
        password { Faker::Internet.password }
        name { Faker::Name.name }
        user_type { "user" }
    end

    factory :admin_user, class: 'User' do
        email { Faker::Internet.email }
        password { Faker::Internet.password }
        name { Faker::Name.name }
        user_type { "admin" }
    end
end