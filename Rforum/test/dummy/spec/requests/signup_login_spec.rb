#encoding: utf-8
require 'spec_helper'

describe "sign up and login" do
  it "let user sign up and login to the site" do
    visit '/ruser/account/sign_in'   
    click_link '注册'
    # save_and_open_page
    fill_in 'user_login', :with => 'rubyist'
    #   save_and_open_page
    fill_in 'user_email', :with => 'rubyist@ruby-china.org'
    fill_in 'user_password', :with => 'coolguy'
    fill_in 'user_password_confirmation', :with => 'coolguy'
     # click_button '提交注册信息'
    click_on '确 定'  
    page.should have_content('注册成功')
    within("#userbar") do
      click_on 'rubyist'
    end

    click_link '退出'
    page.should have_content('退出成功.')

    click_link '登录'
    fill_in 'user_login', :with => 'rubyist'
    fill_in 'user_password', :with => 'coolguy'
    click_button '登录'
    page.should have_content('登录成功')
  end

  it "fail to sign up new user if password field is protected" do
    Ruser::User.class_eval do
      attr_protected :password
    end
   visit '/ruser/account/sign_in'   
    click_link '注册'
    fill_in 'user_login',:with => 'rubyist'
    fill_in 'user_email', :with => 'rubyist@ruby-china.org'
    fill_in 'user_password', :with => ''
    fill_in 'user_password_confirmation', :with => '1234'
    # click_button '提交注册信息'
    click_on '确 定'  
    page.should have_content('不能为空字符')
    page.should have_content('与确认值不匹配')
  end
end

