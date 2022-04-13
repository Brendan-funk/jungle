class User < ActiveRecord::Base



  # Returns self if the password is correct, otherwise false.
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :password, confirmation: true
  validates :password, length: { minimum: 3 }


  def self.authenticate_with_credentials(email, password)

    # Sets login email and database email to lowercase for comparison
    user = User.where("LOWER(email) = LOWER(?)", email.strip).first

    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end