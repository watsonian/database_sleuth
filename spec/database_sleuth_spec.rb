require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "DatabaseSleuth" do  
  context "when searching Drupal" do
    before(:all) do
      Dir.chdir(File.join(File.dirname(__FILE__), "drupal")) do
        @sleuth = DatabaseSleuth.new(:drupal)
        @sleuth.find_db_info
      end
    end
    
    it "should find the database name" do
      @sleuth.dbname.should == "putyourdbnamehere"
    end
    
    it "should find the username" do
      @sleuth.dbuser.should == "usernamehere"
    end
    
    it "should find the user password" do
      @sleuth.dbpass.should == "yourpasswordhere"
    end
    
    it "should find the hostname" do
      @sleuth.dbhost.should == "localhost"
    end
    
    it "should produce a manual connection string" do
      @sleuth.manual_connection_string.should == "mysql -u usernamehere -pyourpasswordhere -h localhost putyourdbnamehere"
    end
  end
  
  context "when searching Gallery" do
    before(:all) do
      Dir.chdir(File.join(File.dirname(__FILE__), "gallery")) do
        @sleuth = DatabaseSleuth.new(:gallery)
        @sleuth.find_db_info
      end
    end
    
    it "should find the database name" do
      @sleuth.dbname.should == "putyourdbnamehere"
    end
    
    it "should find the username" do
      @sleuth.dbuser.should == "usernamehere"
    end
    
    it "should find the user password" do
      @sleuth.dbpass.should == "yourpasswordhere"
    end
    
    it "should find the hostname" do
      @sleuth.dbhost.should == "localhost"
    end
    
    it "should produce a manual connection string" do
      @sleuth.manual_connection_string.should == "mysql -u usernamehere -pyourpasswordhere -h localhost putyourdbnamehere"
    end
  end
  
  context "when searching Joomla" do
    before(:all) do
      Dir.chdir(File.join(File.dirname(__FILE__), "joomla")) do
        @sleuth = DatabaseSleuth.new(:joomla)
        @sleuth.find_db_info
      end
    end
    
    it "should find the database name" do
      @sleuth.dbname.should == "putyourdbnamehere"
    end
    
    it "should find the username" do
      @sleuth.dbuser.should == "usernamehere"
    end
    
    it "should find the user password" do
      @sleuth.dbpass.should == "yourpasswordhere"
    end
    
    it "should find the hostname" do
      @sleuth.dbhost.should == "localhost"
    end
    
    it "should produce a manual connection string" do
      @sleuth.manual_connection_string.should == "mysql -u usernamehere -pyourpasswordhere -h localhost putyourdbnamehere"
    end
  end
  
  context "when searching MediaWiki" do
    before(:all) do
      Dir.chdir(File.join(File.dirname(__FILE__), "mediawiki")) do
        @sleuth = DatabaseSleuth.new(:mediawiki)
        @sleuth.find_db_info
      end
    end
    
    it "should find the database name" do
      @sleuth.dbname.should == "putyourdbnamehere"
    end
    
    it "should find the username" do
      @sleuth.dbuser.should == "usernamehere"
    end
    
    it "should find the user password" do
      @sleuth.dbpass.should == "yourpasswordhere"
    end
    
    it "should find the hostname" do
      @sleuth.dbhost.should == "localhost"
    end
    
    it "should produce a manual connection string" do
      @sleuth.manual_connection_string.should == "mysql -u usernamehere -pyourpasswordhere -h localhost putyourdbnamehere"
    end
  end
  
  context "when searching phpBB" do
    before(:all) do
      Dir.chdir(File.join(File.dirname(__FILE__), "phpbb")) do
        @sleuth = DatabaseSleuth.new(:phpbb)
        @sleuth.find_db_info
      end
    end
    
    it "should find the database name" do
      @sleuth.dbname.should == "putyourdbnamehere"
    end
    
    it "should find the username" do
      @sleuth.dbuser.should == "usernamehere"
    end
    
    it "should find the user password" do
      @sleuth.dbpass.should == "yourpasswordhere"
    end
    
    it "should find the hostname" do
      @sleuth.dbhost.should == "localhost"
    end
    
    it "should produce a manual connection string" do
      @sleuth.manual_connection_string.should == "mysql -u usernamehere -pyourpasswordhere -h localhost putyourdbnamehere"
    end
  end
  
  context "when searching WordPress" do
    before(:all) do
      Dir.chdir(File.join(File.dirname(__FILE__), "wordpress")) do
        @sleuth = DatabaseSleuth.new(:wordpress)
        @sleuth.find_db_info
      end
    end
    
    it "should find the database name" do
      @sleuth.dbname.should == "putyourdbnamehere"
    end
    
    it "should find the username" do
      @sleuth.dbuser.should == "usernamehere"
    end
    
    it "should find the user password" do
      @sleuth.dbpass.should == "yourpasswordhere"
    end
    
    it "should find the hostname" do
      @sleuth.dbhost.should == "localhost"
    end
    
    it "should find the database table prefix" do
      @sleuth.dbtableprefix.should == "wp_"
    end
    
    it "should produce a manual connection string" do
      @sleuth.manual_connection_string.should == "mysql -u usernamehere -pyourpasswordhere -h localhost putyourdbnamehere"
    end
  end
  
  context "when searching ZenCart" do
    before(:all) do
      Dir.chdir(File.join(File.dirname(__FILE__), "zencart")) do
        @sleuth = DatabaseSleuth.new(:zencart)
        @sleuth.find_db_info
      end
    end
    
    it "should find the database name" do
      @sleuth.dbname.should == "putyourdbnamehere"
    end
    
    it "should find the username" do
      @sleuth.dbuser.should == "usernamehere"
    end
    
    it "should find the user password" do
      @sleuth.dbpass.should == "yourpasswordhere"
    end
    
    it "should find the hostname" do
      @sleuth.dbhost.should == "localhost"
    end
    
    it "should produce a manual connection string" do
      @sleuth.manual_connection_string.should == "mysql -u usernamehere -pyourpasswordhere -h localhost putyourdbnamehere"
    end
  end
end
