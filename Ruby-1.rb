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

       

        encoding_options = {
          :invalid           => :replace,  # Replace invalid byte sequences
          :undef             => :replace,  # Replace anything not defined in ASCII
          :replace           => '',        # Use a blank for those replacements
          :universal_newline => true       # Always break lines with \n
        }
        
        resource :data do 
            
            get do 
                
                hash = {}
                
                begin
                    con = Mysql.new('127.0.0.1', 'root', 'open', 'UserLogs')
                    
                rescue
                    hash[:fail] = "mySQL fails"
                    
                ensure
                    queryResponse = con.query("SELECT * IN Daily")
                    
                    hash[:daily] = queryResponse
                    
                    queryResponse = con.query("SELECT * IN Weekly")
                    
                    hash[:weekly] = queryResponse
                    
                    hash

        resource :daily do
          post do
              
            hash = {}
              
            begin
                con = Mysql.new('127.0.0.1', 'root', 'open', 'UserLogs')
            rescue
             
                hash[:fail] = "mySQL fails"
             
            ensure
            
                puts "INSERT INTO Daily (date) VALUES ('#{params[:date]}')"
                queryResponse = con.query("INSERT INTO Daily (date, dateposted) VALUES ('#{params[:date]}', now())")
                
                hash[:success] = "Sucess"
             
            end
            
            hash
            
          end
        end

        resource :weekly do
          post do
            
            hash = {}
              
            begin
                con = Mysql.new('127.0.0.1', 'root', 'open', 'UserLogs')
            rescue
             
                hash[:fail] = "mySQL fails"
             
            ensure
            
                
                puts "INSERT INTO Weekly (date) VALUES ('#{params[:date]}')"
                queryResponse = con.query("INSERT INTO Weekly (date, dateposted) VALUES ('#{params[:date]}', now())")
            
                hash[:success] = "Sucess"
             
            end
            
            hash

          end
        end


      end
end
