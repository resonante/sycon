class User < ActiveRecord::Base
  has_many :assignments, dependent: :destroy
  has_many :roles, :through => :assignments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	acts_as_messageable

	#Returning any kind of identification you want for the model
	def name
	  return self.email
	end

	#Returning the email address of the model if an email should be sent for this object (Message or Notification).
	#If no mail has to be sent, return nil.
	def mailboxer_email(object)
	  #Check if an email should be sent for that object
	  #if true
	  return "define_email@on_your.model"
	  #if false
	  #return nil
	end

end
