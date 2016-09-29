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
  validates :street, presence: true, allow_nil: false, allow_blank: false
  validates :zipcode,
    presence: true,
    length: { is: 5 }
  validates :phone_number, presence: true, length:{ is: 10 }
  validates :city, presence: true
  validates :state, presence: true, inclusion: { in: STATES }
  validates :other_address, presence: false, allow_nil: true


  def admin?
    role == "admin"
  end

  def fullname
    "#{first_name} #{last_name}"
  end

  def full_address
    if other_address.nil
      "#{street}\n
      #{other_address}\n
      #{city}, #{state} #{zipcode}"
    else
      "#{street}\n
      #{city}, #{state} #{zipcode}"
    end
  end
end
