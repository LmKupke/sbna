class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  STATES = %w(
    AL AK AS AZ AR CA CO CT DE DC FM FL GA GU HI ID IL IN IA KS KY LA ME MH
    MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND MP OH OK OR PW PA PR RI SC
    SD TN TX UT VT VI VA WA WV WI WY AE AA AP
  )

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
   presence: true,
   allow_nil: false,
   format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i },
   uniqueness: true
  validates :street, presence: true, allow_nil: false, allow_blank: false,
    format: { with: /\d{1,4}( \w+){1,4}/, message: "Please have house number and street name and street suffix"}
  validates :zipcode,
    presence: true,
    length: { is: 5 }
  validates :phone_number, presence: true, length:{ is: 10 }
  validates :city, presence: true
  validates :state, presence: true, inclusion: { in: STATES }
  validates :other_address, presence: false, allow_nil: true
  mount_uploader :profphoto, ProfilePhotoUploader

  has_many :events
  has_many :attendees
  
  def admin?
    role == "admin"
  end

  def fullname
    "#{first_name} #{last_name}"
  end

  def full_address
    "#{street}
    #{other_address}
    #{city}, #{state} #{zipcode}"
  end
end
