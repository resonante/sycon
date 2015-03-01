class WorkAssignment < ActiveRecord::Base
  belongs_to :agent
  belongs_to :work
end