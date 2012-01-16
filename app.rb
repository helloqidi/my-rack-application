#!/usr/bin/env ruby
require "rack"
require "yaml"
require "logger"
require 'active_record'

#加载controller
require_relative "app/email_controller.rb"
include EmailController

#加载model
require_relative "model/email.rb"

#链接数据库
config = YAML::load(File.open(File.dirname(__FILE__) + "/config.yml"))
ActiveRecord::Base.establish_connection(config)

#设置日志的write方法
Logger.class_eval { alias :write :'<<' }


#设置Rack
builder = Rack::Builder.new do
  use Rack::CommonLogger, Logger.new("log/rack.log") 
  use Rack::ContentType, "text/html"
  use Rack::ContentLength
  
  map "/" do
    run lambda{|env| [200, {}, [File.read("views/index.html")]]}
  end

  map "/contact" do
    run lambda{|env| [200, {}, [process_request(env)]]}
  end
end
Rack::Handler::WEBrick.run builder, :Port => 8080
