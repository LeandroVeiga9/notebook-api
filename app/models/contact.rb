class Contact < ApplicationRecord
  belongs_to :kind #, optional: true
  has_many :phones
  has_one :address

  before_destroy :destroy_phones
  before_destroy :destroy_addresses

  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address, update_only: true

  def as_json(options={})
    h = super(options)
    h[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
    h
  end

  private
   
    def destroy_phones
      self.phones.destroy_all
    end
  
    def destroy_addresses
      self.address.destroy
    end

end
