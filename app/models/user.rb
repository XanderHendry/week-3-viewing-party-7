class User <ApplicationRecord 
  validates_presence_of :email, :name, :password
  validates_confirmation_of :password
  validates :email, uniqueness: { case_sesitive: false}
  has_secure_password

  has_many :viewing_parties
end 
