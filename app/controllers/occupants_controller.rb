class OccupantsController < ApplicationController
  # GET /occupants
  # GET /occupants.xml
  def index
    @occupants = Occupant.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @occupants }
    end
  end

  # GET /occupants/1
  # GET /occupants/1.xml
  def show
    @occupant = Occupant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @occupant }
    end
  end

  # GET /occupants/new
  # GET /occupants/new.xml
  def new
    @occupant = Occupant.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @occupant }
    end
  end

  # GET /occupants/1/edit
  def edit
    @occupant = Occupant.find(params[:id])
  end

  # POST /occupants
  # POST /occupants.xml
  def create
    @occupant = Occupant.new(params[:occupant])

    respond_to do |format|
      if @occupant.save
        flash[:notice] = 'Occupant was successfully created.'
        format.html { redirect_to(@occupant) }
        format.xml  { render :xml => @occupant, :status => :created, :location => @occupant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @occupant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /occupants/1
  # PUT /occupants/1.xml
  def update
    @occupant = Occupant.find(params[:id])

    respond_to do |format|
      if @occupant.update_attributes(params[:occupant])
        flash[:notice] = 'Occupant was successfully updated.'
        format.html { redirect_to(@occupant) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @occupant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /occupants/1
  # DELETE /occupants/1.xml
  def destroy
    @occupant = Occupant.find(params[:id])
    @occupant.destroy

    respond_to do |format|
      format.html { redirect_to(occupants_url) }
      format.xml  { head :ok }
    end
  end

  ###############################
  

end
