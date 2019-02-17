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
    begin
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
    rescue
      flash[:warning] = "archivo invalido, debe ser un archivo CSV, descarga el archivo sample"
    end
    redirect_to students_path
  end

  def destroy
    voter = Voter.find(params[:id])
    votergroup = Voter.find(params[:id]).group_id
    voterid = voter.identification
    if voter.code_id
      code = Code.find(voter.code_id)
      votercode = code.code
      code.destroy
    end
    voter.destroy
    flash[:success] = "Se ha eliminado el estudiante #{voterid} #{"y el codigo #{votercode}" if voter.code_id}"
    redirect_to showgroup_path(votergroup)
  end
end
