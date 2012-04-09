FactoryGirl.define do
  factory :user ,:class => Ruser::User do
    sequence(:name){|n| "name#{n}" }
    sequence(:login){|n| "login#{n}" }
    sequence(:email){|n| "email#{n}@ruby-chine.org" }
    password 'password'
    password_confirmation 'password'
    location "China"
  end

  factory :admin, :parent => :user do
    email Ruser::Setting.admin_emails.first
  end

  factory :wiki_editor, :parent => :user

  factory :non_wiki_editor, :parent => :user do
    verified false
  end
end
