require 'csv'


class AlunosController < ApplicationController

    def index
        


    end


    def search

        file_path = Rails.root.join('public', 'alunos.txt')

        siape_digitado = params[:siape]

        siape_encontrado = false
        @nome_encontrado = nil

       
        

        CSV.foreach(file_path, headers: true) do |row|
            siape_csv = row['matricula']
            status = row['status']
            nome = row['nome']
            
      
            if siape_csv == siape_digitado && status.downcase == 'ativo'
              siape_encontrado = true
              @nome_encontrado = row['nome'].downcase
              @email_com_id_uff = row['email'].sub "email@gmail.com", @nome_encontrado+"@id.uff.br"
              @nome_split = @nome_encontrado.split(' ')

              @opcoes_de_emails = []

              @opcoes_de_emails << @nome_split[0] + @nome_split[1] + @nome_split[2] + "@id.uff.br"
              @opcoes_de_emails << @nome_split[0] + @nome_split[1] + "@id.uff.br" 
              @opcoes_de_emails << @nome_split[0] + @nome_split[2] + "@id.uff.br" 
              @opcoes_de_emails << @nome_split[0] + "@id.uff.br" 
              @opcoes_de_emails << @nome_split[0] + "_" + @nome_split[1]+ "@id.uff.br" 
              @opcoes_de_emails << @nome_split[0] + "_" + @nome_split[2]+ "@id.uff.br" 
              @opcoes_de_emails << @nome_split[0][0] + "_" + @nome_split[0] + "@id.uff.br" 
              @opcoes_de_emails <<  @nome_split[0][0] + "_" + @nome_split[1] + "@id.uff.br" 
              @opcoes_de_emails << @nome_split[0][0] + "_" + @nome_split[2] + "@id.uff.br"           
              
              break
            end

        end

        if siape_encontrado
            flash[:notice] = "SIAPE ativo encontrado!  #{@nome_encontrado}"
            
        else
            flash[:notice] = "SIAPE não encontrado ou não está ativo."
        end




       render :index

    end










end
