package servlet;


/**
 * ThingSpeak Java Client Copyright 2014, Andrew Bythell <abythell@ieee.org>
 * http://angryelectron.com
 *
 * The ThingSpeak Java Client is free software: you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version.
 *
 * The ThingSpeak Java Client is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * theThingSpeak Java Client. If not, see <http://www.gnu.org/licenses/>.
 */
import com.angryelectron.thingspeak.Channel;
import com.angryelectron.thingspeak.Channel;
import com.angryelectron.thingspeak.Entry;
import com.angryelectron.thingspeak.Entry;
import com.angryelectron.thingspeak.Feed;
import com.angryelectron.thingspeak.Feed;
import com.angryelectron.thingspeak.FeedParameters;
import com.angryelectron.thingspeak.FeedParameters;

import java.util.ArrayList;
import java.util.Map;
import java.util.List;

public class Tasks {

    public static void pull() throws Exception {
        // Thingspeak parameters
        String thingspeakServer = "https://api.thingspeak.com";
        int channelID = 56725;
        int field = 1;
        int numResultsToFetch = 10;
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
        int max = 4;
        double total = 0;
        double maximum = 0;
        for (Integer inter : fieldList) {
            // Get feed
            Feed publicFeed = channel.getChannelFeed();
            Feed feed = channel.getFieldFeed(inter, options);
            total = 0;
            ArrayList<Entry> entriesArrayList = feed.getEntryList();
            Map<Integer, Entry> entriesMap = feed.getEntryMap();

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
                System.out.format("Field %s: %s\n", name, entry.getField(inter));
                total += Double.parseDouble(entry.getField(inter).toString());
            }
            //double max2 = (double) max;
            double average = total / max;

//        System.out.println("Total : " + total);
            //System.out.println("Max : " + max);
            System.out.println("Average : " + average + "(of "+ max + " results)");
        }

//        entry = entriesArrayList.get(0);
//        System.out.format("Field %d: %s\n", field, entry.getField(field));
//        entry = entriesArrayList.get(1);
//        System.out.format("Field %d: %s\n", field, entry.getField(field));
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

    public static void main(String[] args) throws Exception {
        boolean cont=true;
        while(cont){
            pull();
            Thread.sleep(1500);
        }
        //push();
        System.out.println("It is finished.");
        System.exit(0);
    }
}
