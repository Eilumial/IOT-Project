/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.angryelectron.thingspeak.Channel;
import com.angryelectron.thingspeak.Entry;
import com.angryelectron.thingspeak.Feed;
import com.angryelectron.thingspeak.FeedParameters;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author David
 */
@WebServlet(name = "Task", urlPatterns = {"/Task"})
public class Task extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //response.setContentType("text/html;charset=UTF-8");
        //try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            //out.println("<!DOCTYPE html>");
           // out.println("<html>");
            //out.println("<head>");
           // out.println("<title>Servlet Task</title>");            
           // out.println("</head>");
           // out.println("<body>");
           // out.println("<h1>Servlet Task at " + request.getContextPath() + "</h1>");
           // out.println("</body>");
           // out.println("</html>");
            try{
                request.setAttribute("list",this.pull());
            }catch(Exception e){
                e.printStackTrace();
            }
            RequestDispatcher view = request.getRequestDispatcher("Display.jsp");
            view.forward(request, response);
        }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    public static HashMap<Integer,ArrayList<String>> pull() throws Exception {
        // Thingspeak parameters
        HashMap<Integer,ArrayList<String>> toReturn=new HashMap<Integer,ArrayList<String>>();
        String thingspeakServer = "https://api.thingspeak.com";
        int channelID = 56725;
        int field = 4;
        int numResultsToFetch = 1;
        ArrayList<Integer> fieldList = new ArrayList<Integer>();

        for (int j = 1; j <= 4; j++) {
            fieldList.add(j);

        }

        // Init new channel object
        Channel channel = new Channel(channelID);
        channel.setUrl(thingspeakServer);

        // Init feed parameters
        FeedParameters options = new FeedParameters();
        options.results(numResultsToFetch);

        // Get entries
        Entry entry = null;
        int max = 1;
        double total = 0;
        double maximum = 0;
        for (Integer inter : fieldList) {
            // Get feed
            Feed publicFeed = channel.getChannelFeed();
            Feed feed = channel.getFieldFeed(inter, options);
            total = 0;
            ArrayList<Entry> entriesArrayList = feed.getEntryList();
            Map<Integer, Entry> entriesMap = feed.getEntryMap();
            ArrayList<String> tempList= new ArrayList<String>();
            for (int i = 0; i < max; i++) {
                entry = entriesArrayList.get(i);
                String name="";
                switch(inter){
                    case 1: name="Temperature";
                            break;
                    case 2: name="GSR";
                            break;
                    case 3: name="Heart Rate";
                            break;
                    case 4: name="Flow Meter";
                            break;
                     
                }
                //System.out.format("Field %d: %s\n", inter, entry.getField(inter));
                //System.out.format("Field %s: %s\n", name, entry.getField(inter));
                tempList.add(entry.getField(inter)+"");
                total += Double.parseDouble(entry.getField(inter).toString());
            }
            //double max2 = (double) max;
            double average = total / max;

//        System.out.println("Total : " + total);
            //System.out.println("Max : " + max);
            System.out.println("Average : " + average + "(of "+ max + " results)");
            toReturn.put(inter,tempList);
        }

//        entry = entriesArrayList.get(0);
//        System.out.format("Field %d: %s\n", field, entry.getField(field));
//        entry = entriesArrayList.get(1);
//        System.out.format("Field %d: %s\n", field, entry.getField(field));
        return toReturn;
    }

    public static void push() throws Exception {
        // Thingspeak parameters
        String thingspeakServer = "https://api.thingspeak.com";
        int pauseBetweenUpdatesSeconds = 16;
        String apiWriteKey = "B43PK5HLKZXUCII7";
        int channelID = 56360;

        // Init new channel object
        Channel channel = new Channel(channelID, apiWriteKey);
        channel.setUrl(thingspeakServer);

        // Push data
        int result = 0;
        int field1 = 1;
        int field2 = 2;
        //int dataToSend = 12;
        int dataToSend = 0;
        //data value to be sent
        for (int i = 0; i < 10; i++) {
            dataToSend = i;

            System.out.format("Sending %d...", dataToSend);

            // Create new entry, set 2 fields to the same value
            Entry entry = new Entry();
            entry.setField(field1, Integer.toString(dataToSend));

            // Update and print the result
            result = channel.update(entry);
            System.out.format("Entry ID: %d.\n", result);

            // Sleep a while
            System.out.format("Sleeping");
            for (int j = pauseBetweenUpdatesSeconds; j > 0; j--) {
                System.out.format(".");
                Thread.sleep(1000);
            }

            System.out.format("\n");

        }

    }

}
