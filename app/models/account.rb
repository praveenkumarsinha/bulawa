class Account < ApplicationRecord

  #==== Constants =====================================================
  #Reserved keywords taken from https://github.com/deanpcmad/saas_deny_subdomains/blob/master/lib/saas_deny_subdomains/subdomains.rb#L6
  RESERVED_SUBDOMAINS = %w( www admin administrator blog dashboard admindashboard assets assets1 assets2 assets3 assets4 assets5 images img files videos help support cname test cache
  api api1 api2 api3 js css static mail ftp webmail webdisk ns ns1 ns2 ns3 ns4 ns5 register pop pop3 beta stage http https donate store payment payments smtp
  ad admanager ads adsense adwords about abuse affiliate affiliates shop client clients code community buy cpanel whm dev developer developers docs email whois
  signup gettingstarted home invoice invoices ios ipad iphone log logs my status network networks new newsite news partner partners partnerpage popular wiki
  redirect random public registration resolver rss sandbox search server servers service signin signup sitemap sitenews sites sms sorry ssl staging development
  stats statistics graph graphs survey surveys talk trac git svn translate upload uploads video validation validations email webmaster ww wwww www1 www2 feeds
  secure demo i img img1 img2 img3 css1 css2 css3 js js1 js2
  billing calendar forum imap login manage mx pages press videos kb knowledgebase )

  #==== Associations ==================================================
  has_many :users, inverse_of: :account, dependent: :destroy
  has_many :apps, inverse_of: :account, dependent: :destroy

  #==== Validations ===================================================
  validates :name, presence: true, length: {within: 1..191}
  validates :subdomain, presence: true
  validates :subdomain, format: {with: /\A[A-Za-z0-9](?:[A-Za-z0-9\-]{0,61}[A-Za-z0-9])?\z/i}
  validates :subdomain, exclusion: {in: RESERVED_SUBDOMAINS}
  validates :subdomain, uniqueness: true

  #==== Callbacks (Filters) ===========================================
  before_save :do_downcase_subdomain

  #==== Accepts nested attributes =====================================
  accepts_nested_attributes_for :users

  private
  def do_downcase_subdomain
    self.subdomain.try(:downcase)
  end


end
