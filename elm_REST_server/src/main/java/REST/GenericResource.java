/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package REST;

import Model.Counter;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

/**
 * REST Web Service
 *
 * @author mathiasjepsen
 */
@Path("counter")
public class GenericResource {
    
    private static final Counter COUNTER = new Counter();
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of GenericResource
     */
    public GenericResource() {
    }
    
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getJson() {
        COUNTER.getCount();
        return gson.toJson(COUNTER);
    }
    
    @POST
    @Path("{value}")
    @Consumes(MediaType.APPLICATION_JSON)
    public String putJson(String content, @PathParam("value") int value) {
        COUNTER.setCount(value);
        return gson.toJson(COUNTER.getWithoutIncrement());
    }
}
