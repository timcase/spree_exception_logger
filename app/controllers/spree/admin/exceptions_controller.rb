module Spree
  module Admin
    class ExceptionsController < Spree::Admin::BaseController
      helper_method :params_filters

      def model_class
        ExceptionLogger::LoggedException
      end

      def index
        @exception_names    = ExceptionLogger::LoggedException.class_names
        @controller_actions = ExceptionLogger::LoggedException.controller_actions
        query
      end

      def show
        @exception = ExceptionLogger::LoggedException.where(:id => params[:id]).first

        respond_to do |format|
          format.js
          format.html
        end
      end

      def query
        exceptions = ExceptionLogger::LoggedException.sorted
        unless params[:id].blank?
          exceptions = exceptions.where(:id => params[:id])
        end
        unless params[:query].blank?
          exceptions = exceptions.message_like(params[:query])
        end
        unless params[:date_ranges_filter].blank?
          exceptions = exceptions.days_old(params[:date_ranges_filter])
        end
        unless params[:exception_names_filter].blank?
          exceptions = exceptions.by_exception_class(params[:exception_names_filter])
        end
        unless params[:controller_actions_filter].blank?
          c_a_params = params[:controller_actions_filter].split('/')
          controller_filter = c_a_params.first.underscore
          action_filter = c_a_params.last.downcase
          exceptions = exceptions.by_controller(controller_filter)
          exceptions = exceptions.by_action(action_filter)
        end
        @exceptions = Kaminari.paginate_array(exceptions).page(params[:page]).per(30)

        respond_to do |format|
          format.html { redirect_to :action => 'index' unless action_name == 'index' }
          format.js
        end
      end


    def params_filters
      {
        :query => params[:query],
        :date_ranges_filter => params[:date_ranges_filter],
        :exception_names_filter => params[:exception_names_filter],
        :controller_actions_filter => params[:controller_actions_filter],
      }
    end

    end
  end
end
