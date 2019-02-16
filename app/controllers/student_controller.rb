require 'csv'    
class StudentController < ApplicationController
  layout "admin"
  before_action :adminPermit
  
  def index
    @totalstudents = Voter.all.count
    @leftstudents = Voter.where(voted: false).count
    @students = Voter.all
    @groups = Group.all
  end
  
  def create
    students = []
    transactionresult = {procesed: 0, created: 0}
    errors = []
    filename = params["file"]
    CSV.foreach(filename.tempfile, headers: true) do |row|
      student = row.to_h
      newstudent = Voter.new(identification: student["id"].to_i, group: Group.find_by(name: student["grupo"]), voted: false, election: Election.last, code: studentemptycode)
      transactionresult[:procesed] += 1
      if newstudent.save
        transactionresult[:created] += 1
      else
        newstudent.errors.full_messages.each {|e| errors << "id: #{student["id"].to_i} grupo: #{student["grupo"]} - error: #{e}" }
      end
    end
    flash[:success] = "se procesaron #{transactionresult[:procesed]} entradas, se crearon #{transactionresult[:created]} estudiantes"
    flash[:danger] = errors
    redirect_to students_path
  end

  def destroy
    voter = Voter.find(params[:id])
    votergroup = Voter.find(params[:id]).group_id
    flash[:success] = "Se ha eliminado el estudiante #{voter.identification}"
    voter.destroy
    redirect_to showgroup_path(votergroup)
  end
end
