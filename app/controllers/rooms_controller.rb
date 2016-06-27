class RoomsController < ApplicationController
  before_filter :config_opentok,:except => [:index]
  
  def index
    @rooms = Room.where(public: true).order("created_at DESC")
    @new_room = Room.new
  end
  
  def create
    p '*'*50
    p request.remote_addr
    p '*'*50
    session = @opentok.create_session request.remote_addr
    params[:room][:sessionId] = session.session_id
    
    @new_room = Room.new(user_params[:room])
    
    respond_to do |format|
      if @new_room.save
        format.html { redirect_to("/party/" + @new_room.id.to_s) }
      else
        format.html { render :controller => ‘rooms’,
        :action => “index” }
      end
    end
  end
  
  def party
    @room = Room.find(params[:id])
    p '*'*50
    p @room
    p '*'*50
    @tok_token = @opentok.generate_token :session_id => @room.sessionId 
  end

  private
    def config_opentok
        @opentok = OpenTok::OpenTok.new ENV['TOKBOX_API_KEY'], ENV['TOKBOX_SECRET_KEY']
      if @opentok.nil?
      end
    end
    def user_params
      params.require(:room).permit(:name, :sessionId, :public)
    end
end
