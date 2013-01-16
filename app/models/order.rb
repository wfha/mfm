class Order < ActiveRecord::Base
  attr_accessible :invoice, :note, :payment_type, :tip, :transaction_id,
                  :user, :user_attributes, :cart, :cart_id, :store, :store_id,
                  :card_type, :card_number, :card_verification, :card_expires_on, :tip_rate

  attr_accessor :card_type, :card_number, :card_verification, :card_expires_on, :tip_rate

  # fix the virtual attribute :card_expires_on bug
  columns_hash["card_expires_on"] = ActiveRecord::ConnectionAdapters::Column.new("card_expires_on", nil, "date")

  belongs_to :store
  belongs_to :cart
  belongs_to :user

  accepts_nested_attributes_for :user

  PAYMENT_TYPES = [['Cash', 'cash'], ['Credit Card', 'credit_card']]
  CREDIT_CARD_TYPES = [["Visa", "visa"], ["MasterCard", "master"], ["Discover", "discover"], ["American Express", "american_express"]]
  TIP_RATES = [['Tip w/ cash', 0], ['Tip 5%', 0.05], ['Tip 10%', 0.1], ['Tip 15%', 0.15], ['Tip 20%', 0.2], ['Tip 25%', 0.25], ['Tip 30%', 0.3]]


  after_create :send_fax

  private
  def send_fax
    client = Savon.client(wsdl: "https://ws.interfax.net/dfs.asmx?WSDL")
    response = client.call(:send_char_fax, :message => {'Username' => '', 'Password' => '',
                                                        'FaxNumber' => '9790000000', 'Data' => '<h1>Order Been Faxed!</h1>',
                                                        'FileType' => 'HTML'})
  end

end
