#require_dependency "ruser/application_controller"


  class Ruser::AdminController < Ruser::RuserController
    def index
       @users = Ruser::User.desc(:_id).paginate :page => params[:page], :per_page => 30
    end
  end

