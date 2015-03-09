package cucumber;

import static org.junit.Assert.assertTrue;

import java.util.logging.Logger;

import cucumber.api.PendingException;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import cucumber.HttpHelper;
import cucumber.RestHelper;


public class RestCallsStepDefinitions {

	private static final Logger LOGGER = Logger.getLogger(RestCallsStepDefinitions.class.getName());
	private static HttpHelper httpHelper;
    private RestHelper restHelper;
	
    private final String testurlbase = "http://localhost:8080/web-mock-1.0.0";
    private String urlbase = "";
    private String params = "";
    private String page = "";
    private String type = "";

    @Given("^a user accessing environment '(.+)'$")
    public void a_user_accessing_environment(String arg1) throws Throwable {
      // Express the Regexp above with the code you wish you had
        if (arg1.equalsIgnoreCase("test")){
            restHelper = new RestHelper("http://localhost",8080,"web-mock-1.0.0/mockups");
        }
      LOGGER.info("Environment = "+arg1);
    }

          @When("^accessing the page '(.+)'$")
  public void accessing_the_page(String arg1) throws Throwable {
          // Express the Regexp above with the code you wish you had
              this.page = arg1;
              LOGGER.info("Page = " + arg1);
      }

          @When("^passing the parameters '(.+)'$")
  public void passing_the_parameters(String arg1) throws Throwable {
          // Express the Regexp above with the code you wish you had
              this.params = arg1;
          LOGGER.info("Parameters = " +arg1);
      }

          @Then("^the content returned should be '(.+)'$")
  public void the_content_returned_should_be(String arg1) throws Throwable {
          // Express the Regexp above with the code you wish you had
              this.type = arg1;
          LOGGER.info("Content returned is of type = " + arg1);
      }

          @Then("^the content returned should contain '(.+)'$")
  public void the_content_returned_should_contain(String arg1) throws Throwable {
              LOGGER.info("Content returned should contain = " +arg1);
          // Express the Regexp above with the code you wish you had
              String path = page + "?" + params;
              LOGGER.info("Testing path " + path);
              Boolean match = restHelper.restCall(path, type, arg1);
              assertTrue(match);
              LOGGER.info("Return status = " + match);

    }
}
