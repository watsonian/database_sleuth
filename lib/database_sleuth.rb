class DatabaseSleuth
  attr_accessor :application, :locations, :exists_at, :located_at, :regex, :dbname, :dbuser, :dbpass, :dbhost, :dbtableprefix
  
  @@supported_applications = [:joomla, :wordpress, :drupal, :phpbb, :gallery, :zencart, :mediawiki]
  
  @@app_metadata = {}
  @@app_metadata[:drupal] = {
    :locations => ["sites/default/settings.php"],
    :regex => {
      :dbname => Regexp.new("^\\$db_url.*?\\/\\/.*?\\/(.*?)'"),
      :dbuser => Regexp.new("^\\$db_url.*?\\/\\/(.*)?:.*?'"),
      :dbpass => Regexp.new("^\\$db_url.*?\\/\\/.*?:(.*)?@.*?'"),
      :dbhost => Regexp.new("^\\$db_url.*?\\/\\/.*?@(.*)?\\/.*?'"),
    },
  }
  @@app_metadata[:gallery] = {
    :locations => ["config.php"],
    :regex => {
      :dbname => Regexp.new("\\$storeConfig\\['database'.*?'(.*?)'"),
      :dbuser => Regexp.new("\\$storeConfig\\['username'.*?'(.*?)'"),
      :dbpass => Regexp.new("\\$storeConfig\\['password'.*?'(.*?)'"),
      :dbhost => Regexp.new("\\$storeConfig\\['hostname'.*?'(.*?)'"),
    },
  }
  @@app_metadata[:joomla] = {
    :locations => ["configuration.php"],
    :regex => {
      :dbname => Regexp.new("\\$db\\s*=\\s*'(.*?)'"),
      :dbuser => Regexp.new("\\$user\\s*=\\s*'(.*?)'"),
      :dbpass => Regexp.new("\\$password\\s*=\\s*'(.*?)'"),
      :dbhost => Regexp.new("\\$host\\s*=\\s*'(.*?)'"),
    },
  }
  @@app_metadata[:mediawiki] = {
    :locations => ["LocalSettings.php"],
    :regex => {
      :dbname => Regexp.new("\\$wgDBname\\s*=\\s*'(.*?)'"),
      :dbuser => Regexp.new("\\$wgDBuser\\s*=\\s*'(.*?)'"),
      :dbpass => Regexp.new("\\$wgDBpassword\\s*=\\s*'(.*?)'"),
      :dbhost => Regexp.new("\\$wgDBserver\\s*=\\s*'(.*?)'"),
    },
  }
  @@app_metadata[:phpbb] = {
    :locations => ["config.php"],
    :regex => {
      :dbname => Regexp.new("dbname\\s*=\\s*'(.*?)'"),
      :dbuser => Regexp.new("dbuser\\s*=\\s*'(.*?)'"),
      :dbpass => Regexp.new("dbpasswd\\s*=\\s*'(.*?)'"),
      :dbhost => Regexp.new("dbhost\\s*=\\s*'(.*?)'"),
    },
  }
  @@app_metadata[:wordpress] = {
    :locations => ["wp-config.php"],
    :regex => {
      :dbname => Regexp.new("DB_NAME'.*?'(.*?)'"),
      :dbuser => Regexp.new("DB_USER'.*?'(.*?)'"),
      :dbpass => Regexp.new("DB_PASSWORD'.*?'(.*?)'"),
      :dbhost => Regexp.new("DB_HOST'.*?'(.*?)'"),
      :dbtableprefix => Regexp.new("\\$table_prefix\\s*=\\s*'(.*?)'"),
    },
  }
  @@app_metadata[:zencart] = {
    :locations => ["includes/configure.php"],
    :regex => {
      :dbname => Regexp.new("DB_DATABASE'.*?'(.*?)'"),
      :dbuser => Regexp.new("DB_SERVER_USERNAME'.*?'(.*?)'"),
      :dbpass => Regexp.new("DB_SERVER_PASSWORD'.*?'(.*?)'"),
      :dbhost => Regexp.new("DB_SERVER'.*?'(.*?)'"),
    },
  }
  
  def initialize(app)
    @exists_at = []
    @dbname = nil
    @dbuser = nil
    @dbpass = nil
    @dbhost = nil
    self.application = app
    self.locations = @@app_metadata[@application][:locations]
    @regex = @@app_metadata[@application][:regex]
  end
  
  def application=(app)
    a = String(app).downcase.to_sym
    if @@supported_applications.include?(a)
      instance_variable_set(:@application, a)
    else
      raise "That application is not supported yet."
    end
  end
  
  def find_db_info
    locate_files
    @exists_at.each do |file|
      File.foreach(file) do |line|
        @dbname ||= @regex[:dbname].match(line)[1] if @regex[:dbname] === line
        @dbuser ||= @regex[:dbuser].match(line)[1] if @regex[:dbuser] === line
        @dbpass ||= @regex[:dbpass].match(line)[1] if @regex[:dbpass] === line
        @dbhost ||= @regex[:dbhost].match(line)[1] if @regex[:dbhost] === line
        @dbtableprefix ||= @regex[:dbtableprefix].match(line)[1] if @regex[:dbtableprefix] === line && @regex.has_key?(:dbtableprefix)
        @located_at = file if @dbname
      end
    end
  end
  
  def manual_connection_string
    "mysql -u #{@dbuser} -p#{@dbpass} -h #{@dbhost} #{@dbname}"
  end
  
  private
    def locate_files
      @locations.each do |loc|
        if File.exists?(loc)
          @exists_at << loc
        end
      end
    end
end