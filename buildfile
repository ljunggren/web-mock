
# ---------------------------------------------------------------------------
# Imports
# ---------------------------------------------------------------------------

#require 'buildr/resolver'

MAIN_BUNDLE      = 'src/main/resources/Bundle.properties'


# Buildr needs THIS_VERSION to be a string.
# VERSION          = File.open(MAIN_BUNDLE) do |f|
  #f.readlines.select {|s| s =~ /^api\.version/}.map {|s| s.chomp.sub(/^.*=/, '')}
#end[0]


PROJECT = 'web-mock'
VERSION = '1.0.0'
THIS_VERSION     = "#{VERSION}"
THIS_POM         = "target/#{PROJECT}-#{VERSION}.pom"
THIS_GROUP = "mats"
COPYRIGHT = "Ljunggren Consulting"

# This artifact
ARTIFACT         = "org.clapper:#{PROJECT}:jar:#{VERSION}"

# Specify Maven 2.0 remote repositories here, like this:
repositories.remote << "http://repo1.maven.org/maven2"
repositories.release_to = "/Library/Tomcat/webapps/"

JUNIT = 'junit:junit:jar:4.11'
COMMONS_IO = 'commons-io:commons-io:jar:2.3'
SERVLET_API = 'javax.servlet:servlet-api:jar:2.5'
COMMONS_LOGGING = 'commons-logging:commons-logging:jar:1.1.1'
CUCUMBER_JUNIT = 'info.cukes:cucumber-junit:jar:1.1.5'
CUCUMBER_JAVA = 'info.cukes:cucumber-java:jar:1.1.5'
CUCUMBER_CORE = 'info.cukes:cucumber-core:jar:1.1.5'
CUCUMBER_DEPS = 'info.cukes:cucumber-jvm-deps:jar:1.0.3'
GHERKIN = 'info.cukes:gherkin:jar:2.12.2'
XMLPULL = 'xmlpull:xmlpull:jar:1.1.3.1'
DOM4J = 'dom4j:dom4j:jar:1.6.1'
JDOM = 'org.jdom:jdom-legacy:jar:1.1.3'
WOODSTOX = 'org.codehaus.woodstox:wstx-lgpl:jar:3.2.6'
CGLIB = 'cglib:cglib:jar:3.1'
XOM = 'xom:xom:jar:1.2.5'
STAX = 'stax:stax:jar:1.2.0_rc2-dev'
CUCUMBER_REPORTING = 'net.masterthought:cucumber-reporting:jar:0.0.23'

REST_ASSURED_T = transitive('com.jayway.restassured:rest-assured:jar:2.4.0')

# Dependency hell - replaced by transitives
# GROOVY_ALL = 'org.codehaus.groovy:groovy-all:jar:2.4.1'
# HTTP_CLIENT = 'org.apache.httpcomponents:httpclient:jar:4.4'
# HTTP_CORE = 'org.apache.httpcomponents:httpcore:jar:4.4'
# HTTP_MIME = 'org.apache.httpcomponents:httpmime:jar:4.4'
# COMMONS_LANG = 'org.apache.commons:commons-lang3:jar:3.3.2'
# JSON_SCHEMA = 'com.jayway.restassured:json-schema-validator:jar:2.4.0'
# HAMCREST = 'org.hamcrest:hamcrest-all:jar:1.3'
# OBJENESIS = 'org.objenesis:objenesis:jar:2.1'
# JSON_PATH = 'com.jayway.jsonpath:json-path:jar:1.2.0'


Project.local_task :wildfly
Project.local_task :deploy


desc "The Web mock project"

define "web-mock" do
  project.version = THIS_VERSION
  project.group = THIS_GROUP

  manifest["Implementation-Vendor"] = COPYRIGHT
  compile.with SERVLET_API, COMMONS_LOGGING, CUCUMBER_JUNIT, CUCUMBER_JAVA, CUCUMBER_DEPS, CUCUMBER_CORE, GHERKIN, XMLPULL,
  DOM4J, JDOM, WOODSTOX, CGLIB, XOM, STAX, JUNIT, CUCUMBER_REPORTING, REST_ASSURED_T, _("src/lib/jsonwriter-1.0-SNAPSHOT.jar")

  # , GROOVY_ALL, HTTP_CLIENT, HTTP_CORE,
  # HTTP_MIME, COMMONS_LANG, JSON_SCHEMA, HAMCREST, OBJENESIS, JSON_PATH, _("src/lib/jsonwriter-1.0-SNAPSHOT.jar")

  resources
  test.compile.with # Add classpath dependencies
  #test.exclude 'cucumber.*'

  test.resources

  package(:war)
  task :wildfly => :package do
    system '~/Work/wildfly-8.2.0.Final/bin/jboss-cli.sh --connect command=:shutdown'
    system 'rm -rf ~/Work/wildfly-8.2.0.Final/standalone/deployments/web-mock-1.0.0*'
    system 'cp target/*.war ~/Work/wildfly-8.2.0.Final/standalone/deployments/'
    system '~/Work/wildfly-8.2.0.Final/bin/standalone.sh &'
  end
  package(:war)
  task :deploy => :package do
    system 'cp -r * /Users/matsljunggren/Cloud/OpenShift/jbossas1'
    end
end

# ---------------------------------------------------------------------------
# Utility Functions
# ---------------------------------------------------------------------------

def msg(s)
  $stderr.puts "*** #{s}"
end
