#!/usr/bin/env ruby
require 'mysql'
require 'grape'
require 'json'
require 'rubygems'
require 'open-uri'
require 'net/http'
require 'date'


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
                    con = Mysql.new('127.0.0.1', 'root', '', 'UserLogs')

                rescue
                    hash[:fail] = "mySQL fails"

                ensure

                    puts "connection succeded"

                    queryResponse = con.query("SELECT * FROM Daily")

                    dailyArray = []

                    queryResponse.each do |row|
                        dailyArray.push(row)
                    end

                    puts dailyArray

                    hash[:daily] = dailyArray

                    weeklyArray = []

                    queryResponse = con.query("SELECT * FROM Weekly")

                    queryResponse.each do |row|
                        weeklyArray.push(row)
                    end

                    hash[:weekly] = weeklyArray

                    puts hash
                end

                hash

            end
        end

        resource :daily do
          post do

            hash = {}

            begin
                con = Mysql.new('127.0.0.1', 'root', '', 'UserLogs')
            rescue

                hash[:fail] = "mySQL fails"

            ensure

                puts "INSERT INTO Daily (date) VALUES ('#{params[:date]}')"
                queryResponse = con.query("INSERT INTO Daily (date, dateposted) VALUES (CURDATE(), NOW())")

                hash[:success] = "Sucess"

                system("cd /var/userAPI")
                system("python UserStats.py")

            end

            hash

          end
        end

        resource :weekly do
          post do

            hash = {}

            begin
                con = Mysql.new('127.0.0.1', 'root', '', 'UserLogs')
            rescue

                hash[:fail] = "mySQL fails"

            ensure


                puts "INSERT INTO Weekly (date) VALUES ('#{params[:date]}')"
                queryResponse = con.query("INSERT INTO Weekly (date, dateposted) VALUES (YEARWEEK(NOW()), NOW())")

                hash[:success] = "Sucess"

                system("cd /var/userAPI")
                system("python UserStats.py")

            end

            hash

          end
        end


      end
end
