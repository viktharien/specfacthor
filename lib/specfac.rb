require 'specfac'
require 'thor'
require 'factory/spec_module'
module SpecFac
  class CLI < Thor
    include Utils
    include SpecModule
    attr_accessor :working_dir, :working_file, :protected_methods, :available_methods, :found_methods

    ######### AVAILABLE COMMANDS
    desc "generate [controller] [actions]", "generates tests for specified actions"
    def generate(*args)
      @working_dir = "spec/controllers"
      # @protected_methods = %w(define_utils_methods_params si si_ca pl)
      @found_methods = SpecModule.methods(false).to_a.map {|item| item.to_s}
      @available_methods = @found_methods # @found_methods - @protected_methods
      @working_file = nil

      controller = args.shift
      actions = args
      sanitize(controller, actions)
    end

    ######## UTILITY METHODS
    #

    no_commands do
      def pull_src(controller, actions)
        if !Dir.exists?(@working_dir)
          Dir.mkdir(@working_dir)
        end
        @working_file = "#{@working_dir}/#{controller.downcase}_controller_spec.rb"
        # Header stuff

        opener(
            "header",
            ["require 'rails_helper'","RSpec.describe #{controller.capitalize}Controller, type: :controller do"]
        )
        # p actions
        Utils.define_utils_methods_params(controller)
        actions != nil ? actions.each {|action| opener("body", SpecModule.public_send(action.to_sym))} : nil
        opener("end", "end")

      end

      def opener(mode, lines)
        filer = lambda {|type, output| File.open(@working_file, type) { |handle| handle.puts output}}
        if mode == "header"
          filer.call("w", nil)
          lines.each do |item|
            filer.call("a", item)
          end
        else
          filer.call("a", lines)
        end
      end

      def sanitize(controller, actions)

        rem = "_controller"
        if controller.include? "_controller"
          controller.gsub!(rem, "")
          # puts controller
        end
        if actions.include?("ALL")
          matched_actions = @available_methods
        else
          matched_actions = []
          actions.each {|action| matched_actions << action if @available_methods.include?(action)}
        end

        # p matched_actions
        pull_src(controller, matched_actions)
      end
    end


  end
end
