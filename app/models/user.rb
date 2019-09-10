class User
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
validates :first_name, :last_name, :phone, presence: true
validates :first_name,:last_name, :format => { :with  => /^[\u0621-\u064A -!$%^&*()_+|~=`{}\[\]:";'<>?,.\/]+$/, :multiline => true}

validates_length_of :phone, is: 10


  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :first_name,         type: String, default: ""
  field :last_name,          type: String, default: ""
  field :phone,              type: String, default: ""
  field :admin,              type: Boolean, default: ""


  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  # field :sign_in_count,      type: Integer, default: 0
  # field :current_sign_in_at, type: Time
  # field :last_sign_in_at,    type: Time
  # field :current_sign_in_ip, type: String
  # field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  has_many :appointments, dependent: :destroy
  has_and_belongs_to_many :doctors
end
