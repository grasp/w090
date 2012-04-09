# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site_node,:class=>Rforum::SiteNode do
    sequence(:name) { |n| "site node #{n}" }
  end
end
