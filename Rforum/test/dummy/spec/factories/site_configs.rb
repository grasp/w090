FactoryGirl.define do
  factory :site_config ,:class => Rforum::SiteConfig do
    sequence(:key) { |n| "key_#{n}" }
    sequence(:value) { |n| "value_#{n}" }
  end
end