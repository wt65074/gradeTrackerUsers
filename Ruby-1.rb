#!/usr/bin/env ruby
require 'mysql'
require 'grape'
require 'json'
require 'rubygems'
require 'open-uri'
require 'net/http'


module UserDataAPI
    class V1 < Grape::API

        version 'v1', using: :param, parameter: "v"
        format :json

        con = Mysql.new('127.0.0.1', 'root', 'open', 'UserLogs')

        encoding_options = {
          :invalid           => :replace,  # Replace invalid byte sequences
          :undef             => :replace,  # Replace anything not defined in ASCII
          :replace           => '',        # Use a blank for those replacements
          :universal_newline => true       # Always break lines with \n
        }

        resource :weekly do
          post do
            
            puts "INSERT INTO weekly (date) VALUES ('#{params[:date]}')"
            queryResponse = con.query("INSERT INTO weekly (date) VALUES ('#{params[:date]}')")
            
          end
        end

        resource :daily do
          post do
            
            puts "INSERT INTO weekly (date) VALUES ('#{params[:date]}')"
            queryResponse = con.query("INSERT INTO weekly (date) VALUES ('#{params[:date]}')"")
            
          end
        end


      end
end
