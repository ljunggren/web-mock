package cucumber;

import com.jayway.restassured.RestAssured;
import com.jayway.restassured.response.Response;
import com.jayway.restassured.response.ResponseBody;

import java.util.logging.Logger;

import static com.jayway.restassured.RestAssured.expect;

public class RestHelper {

    private static final Logger LOGGER = Logger.getLogger(RestHelper.class.getName());

    public RestHelper(String host, int port, String basePath){
        RestAssured.baseURI = host;
        RestAssured.port = port;
        RestAssured.basePath = basePath;
    }

    public boolean restCall(String path, String type, String keys){
        Response response = expect().statusCode(200).when().get(path);
        ResponseBody body = response.getBody();
        String bodyString = body.asString();
        LOGGER.info("JSON Body = " + bodyString);

        if (bodyString.contains(keys)) {
            return true;
        } else
        {
            return false;
        }
    }
}