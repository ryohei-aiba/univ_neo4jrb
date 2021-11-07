require "json"

class University 
  include Neo4j::ActiveNode
  id_property :code
  property :name, type: String
  self.mapped_label_name = '大学'
  has_many :out, :faculties, type: :has, unique: true
  validates :name, :presence => true
end

File.open(Rails.root + 'app/models/concerns/school.json') do |file|  
  hash = JSON.load(file)

  i=0

  while i<=(hash.length - 1) 
    if i.even? || i==0
      unless University.find_by(name: hash[i]["大学"])
        uni = University.create(name: hash[i]["大学"])
        uni.faculties = []
        hash[i+1]["学部"].map do |name|   
          if !Faculty.find_by(name: name)
            uni.faculties << Faculty.create(name: name)
          else
            Faculty.find_by(name: name).universities << uni
          end
        end
      end  
    end 
  i+=1
  end 
end