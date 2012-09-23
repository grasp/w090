#coding:utf-8
require 'rubygems'
require 'logger'
require 'pathname'
require 'forever'
#require './cargo_cron_helper.rb'
require 'mongoid'
require '../cron_init.rb'
require '../cron_common.rb'
require './56qq_cron_helper.rb'


require 'mechanize'
require "sqlite3"
require 'active_support'


#init to load cookie

#here we dont need cookie load


#TODO first connect to mongodb should run this in helper
Mongoid.database = Mongo::Connection.new('localhost', 27017).db('w090_dev') #first set as grasp

#to define log in development level and production level
logger=Logger.new("56qq_cargo.log", shift_age = 30, shift_size = 1048576)
logger.level = Logger::DEBUG
#logger.level = Logger::WARN 

#main program here
Forever.run do  
   logger.info "56qq cargo cron start successfully on #{Time.now}!"
   every 5.minutes do
     all_raw_cargo=qq56_cargo_cron(logger)    
    
    if (all_raw_cargo||"").size==0 
      logger.warn "56qq cargo cron got no any cargo #{Time.now}!"
    end 

    #save database 
    save_cargo(all_raw_cargo,logger)

    #post here or we use a post cron for all of site?

     logger.info "one cycle finished on #{Time.now},cost=!"
    end

  on_error do |e|    
    logger.ERROR "56qq cargo cron Boom raised: #{e.message} #{Time.now}!"
  end

  on_exit do
    logger.ERROR "56qq cargo cron Bye bye on #{Time.now}!"
  end
 end

