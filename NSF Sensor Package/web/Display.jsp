<%-- 
    Document   : Display
    Created on : Nov 13, 2015, 8:58:46 PM
    Author     : David
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title></title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <%--<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>--%>
        <script type="text/javascript" src="script.js"></script>

        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="apple-touch-icon" href="apple-touch-icon.png">
        <style>
            .progress {background: rgba(230, 230, 230, 1); border: 2px solid #FFFFFF; border-radius: 12px; height: 20px;}
            .progress-bar-success1 {background: rgba(65, 201, 87, 1);}
            .progress-bar-info1 {background: rgba(19, 203, 240, 1);}
            .progress-bar-warning1 {background: rgba(240, 126, 19, 1);}
            .progress-bar-danger1 {background: rgba(240, 19, 19, 1);}
            .bordered {
                background-color:#eee;
                border: 1px solid #888;
                border-radius:3px;
            }
            .bordered-thick {
                background-color:#eee;
                border: 3px solid;
                border-radius:3px;
            }

            .panel > .panel-heading {
                background-image: none;
                //background-color: #1253A4;
                //background-color: #293E6A;
                //background-color: #639BF1;
                background-color: #3399FF;
                
                color: white;

            }
            
            .panel > .panel-body {
                background-image: none;
                //background-color: #1253A4;
                //background-color: #3B5998;
                background-color: #333399;

            }
            
            .img-icons {
                background-image: none;
                background-color: #293E6A;
            }
            
            .img-whitebg{
                background-image: none;
                background-color: #FFFFFF;
            }
        </style>
        <!--<link rel="stylesheet" href="css/bootstrap.min.css">-->
    </head>
    <body>


        <meta http-equiv="Refresh" content="15;url=Task">
        <div class="panel panel-info img-rounded col-sm-6" id="myPanel">

            <div class="panel-heading"><img  src="lcp.png" height="25" width="25"> LCP Beng</div>

            <div class="panel-body">
                <div class="col-sm-3">

                    <div><img class="bordered-thick" src="coverflow.jpg" height="100" width="80"></div>

                </div>
                <div class="col-sm-9">
                    <%
                        //<img src="lcp.png" height="25" width="25">
                        //response.setIntHeader("Refresh", 20); 
                        //out.println("Waiting...<br>");
                        HashMap<Integer, ArrayList<String>> list = (HashMap<Integer, ArrayList<String>>) request.getAttribute("list");
                        double tempe = 0.0, gsr = 0.0, hrate = 0.0, flow = 0.0;
                        int tempe_score = 0, gsr_score = 0, hrate_score = 0, flow_score = 0;
                        if (list != null) {
                            Set<Integer> intSet = list.keySet();
                            Iterator<Integer> intIter = intSet.iterator();

                            while (intIter.hasNext()) {
                                int tempInt = intIter.next();
                                String name = "";
                                switch (tempInt) {
                                    case 1:
                                        name = "Temperature";
                                        break;
                                    case 2:
                                        name = "GSR";
                                        break;
                                    case 3:
                                        name = "Heart Rate";
                                        break;
                                    case 4:
                                        name = "Flow Meter";
                                        break;

                                }

                                ArrayList<String> stringList = list.get(tempInt);
                                for (String s : stringList) {
                    %><%--<%="Field " + name + ": " + s%><br>--%><%
                        switch (tempInt) {
                            case 1: //name="Temperature";
                                tempe = Double.parseDouble(s);
                                //out.println("Inside: " + tempe);
                                if (tempe <= 36.8) {
                                    tempe_score = 0;
                    %>
                    <img src="Icons/Temperature/white_temperature.png" height="50" width="30">
                    <%
                    } else if (tempe >= 36.9 && tempe <= 37.4) {
                        tempe_score = 2;
                    %>
                    <img src="Icons/Temperature/green_temperature.png" height="50" width="30">
                    <%
                    } else if (tempe >= 37.5 && tempe <= 37.9) {
                        tempe_score = 6;
                    %>
                    <img src="Icons/Temperature/yellow_temperature.png" height="50" width="30">
                    <%
                    } else if (tempe >= 38) {
                        tempe_score = 14;
                    %>
                    <img src="Icons/Temperature/red_temperature.png" height="50" width="30">
                    <%
                            }

                            break;
                        case 2: //name="GSR";
                            gsr = Double.parseDouble(s);
                            //out.println("Inside: " + gsr);
                            if (gsr > 250) {
                                gsr_score = 0;
                    %>
                    <img src="Icons/Stress/white_stress.png" height="50" width="50">
                    <%
                    } else if (gsr >= 200 && gsr <= 249) {
                        gsr_score = 0;
                    %>
                    <img src="Icons/Stress/green_stress.png" height="50" width="50">
                    <%
                    } else if (gsr >= 150 && gsr <= 199) {
                        gsr_score = 1;
                    %>
                    <img src="Icons/Stress/yellow_stress.png" height="50" width="50">
                    <%
                    } else if (gsr < 150) {
                        gsr_score = 2;
                    %>
                    <img src="Icons/Stress/red_stress.png" height="50" width="50">
                    <%
                            }

                            break;
                        case 3: //name="Heart Rate";
                            hrate = Double.parseDouble(s);
                            //out.println("Inside: " + hrate);
                            if (hrate < 120.0) {
                                hrate_score = 0;
                    %>
                    <img src="Icons/Heart/white_heart.png" height="50" width="50">
                    <%
                    } else if (hrate >= 120.0 && hrate < 150.0) {
                        hrate_score = 2;
                    %>
                    <img src="Icons/Heart/green_heart.png" height="50" width="50">
                    <%
                    } else if (hrate >= 150.0 && hrate < 170.0) {
                        hrate_score = 4;
                    %>
                    <img src="Icons/Heart/yellow_heart.png" height="50" width="50">
                    <%
                    } else if (hrate > 170) {
                        hrate_score = 6;
                    %>
                    <img src="Icons/Heart/red_heart.png" height="50" width="50">
                    <%
                            }

                            break;
                        case 4: //name="Flow Meter";
                            flow = Double.parseDouble(s);
                            //out.println("Inside: " + flow);
                            flow_score = 1;

                    %>
                    <img src="Icons/Water/white_water.png" height="50" width="50">
                    <%                                flow = flow * 60.0 / 7.5;
                                    break;

                            }

                        }
                    %><%
                        }%><br><br><%
                        int heat_risk_rating = tempe_score + gsr_score + hrate_score + flow_score;

//DEBUG HARD CODE
                        //heat_risk_rating = 13;
                        if (heat_risk_rating <= 3) {
//out.println("Safe Level of Risk");
                            //CHANGE style="width:5%" attribute to change bar length!
                    %>
                    <div class="progress">
                        <div class="progress-bar progress-bar-info1" role="progressbar" aria-valuenow="15"
                             aria-valuemin="0" aria-valuemax="100" style="width:15%">
                            Safe Level of Risk
                        </div>
                    </div>
                    <%
                    } else if (heat_risk_rating >= 4 && heat_risk_rating <= 7) {
                                //out.println("Low Risk");
                    %>
                    <div class="progress">
                        <div class="progress-bar progress-bar-success1" role="progressbar" aria-valuenow="35"
                             aria-valuemin="0" aria-valuemax="100" style="width:35%">
                            Low Risk
                        </div>
                    </div>
                    <%
                    } else if (heat_risk_rating >= 8 && heat_risk_rating <= 13) {
                                //out.println("Moderate Risk");
                    %>
                    <div class="progress">
                        <div class="progress-bar progress-bar-warning1" role="progressbar" aria-valuenow="65"
                             aria-valuemin="0" aria-valuemax="100" style="width:65%">
                            Moderate Risk
                        </div>
                    </div>
                    <%
                    } else if (heat_risk_rating >= 14) {
                                //out.println("High Risk!");
                    %>
                    <div class="progress">
                        <div class="progress-bar progress-bar-danger1" role="progressbar" aria-valuenow="100"
                             aria-valuemin="0" aria-valuemax="100" style="width:100%">
                            High Risk! Contact medics immediately!
                        </div>
                    </div>
                    <%
                            }

                        }


                    %>
                </div>
            </div>
        </div>



        <!---- Fake entries ----->




        <div class="panel panel-info img-rounded col-sm-6">
            <div class="panel-heading"><img src="CFC.png" height="25" width="25"> CFC Joe</div>
            <div class="panel-body">
                <div class="col-sm-3">

                    <div><img class="bordered-thick" src="coverflow.jpg" height="100" width="80"></div>

                </div>

                <div class="col-sm-9">

                    <img src="Icons/Temperature/yellow_temperature.png" height="50" width="30">

                    <img src="Icons/Stress/yellow_stress.png" height="50" width="50">

                    <img src="Icons/Heart/yellow_heart.png" height="50" width="50">

                    <img src="Icons/Water/yellow_water.png" height="50" width="50">
                    <%--<img src="Icons/Temperature/white_temperature.png" height="50" width="30">

                <img src="Icons/Temperature/green_temperature.png" height="50" width="30">

                <img src="Icons/Temperature/yellow_temperature.png" height="50" width="30">

                <img src="Icons/Temperature/red_temperature.png" height="50" width="30">

                <img src="Icons/Stress/white_stress.png" height="50" width="50">

                <img src="Icons/Stress/green_stress.png" height="50" width="50">

                <img src="Icons/Stress/yellow_stress.png" height="50" width="50">

                <img src="Icons/Stress/red_stress.png" height="50" width="50">

                <img src="Icons/Heart/white_heart.png" height="50" width="50">

                <img src="Icons/Heart/green_heart.png" height="50" width="50">

                <img src="Icons/Heart/yellow_heart.png" height="50" width="50">

                <img src="Icons/Heart/red_heart.png" height="50" width="50">

                <img src="Icons/Water/white_water.png" height="50" width="50">--%>
                    <br>
                    <br>
                    <div class="progress">
                        <div class="progress-bar progress-bar-warning1" role="progressbar" aria-valuenow="65"
                             aria-valuemin="0" aria-valuemax="100" style="width:65%">
                            Moderate Risk
                        </div>
                    </div>
                </div>
            </div>
        </div>













        <div class="panel panel-info img-rounded col-sm-6">
            <div class="panel-heading"><img src="3SG.png" height="25" width="25"> 3SG Chris</div>
            <div class="panel-body">
                <div class="col-sm-3">

                    <div><img class="bordered-thick" src="coverflow.jpg" height="100" width="80"></div>

                </div>

                <div class="col-sm-9">

                    <img src="Icons/Temperature/green_temperature.png" height="50" width="30">

                    <img src="Icons/Stress/white_stress.png" height="50" width="50">

                    <img src="Icons/Heart/green_heart.png" height="50" width="50">

                    <img src="Icons/Water/green_water.png" height="50" width="50">
                    <%--<img src="Icons/Temperature/white_temperature.png" height="50" width="30">

                <img src="Icons/Temperature/green_temperature.png" height="50" width="30">

                <img src="Icons/Temperature/yellow_temperature.png" height="50" width="30">

                <img src="Icons/Temperature/red_temperature.png" height="50" width="30">

                <img src="Icons/Stress/white_stress.png" height="50" width="50">

                <img src="Icons/Stress/green_stress.png" height="50" width="50">

                <img src="Icons/Stress/yellow_stress.png" height="50" width="50">

                <img src="Icons/Stress/red_stress.png" height="50" width="50">

                <img src="Icons/Heart/white_heart.png" height="50" width="50">

                <img src="Icons/Heart/green_heart.png" height="50" width="50">

                <img src="Icons/Heart/yellow_heart.png" height="50" width="50">

                <img src="Icons/Heart/red_heart.png" height="50" width="50">

                <img src="Icons/Water/white_water.png" height="50" width="50">--%>
                    <br>
                    <br>
                    <div class="progress">
                        <div class="progress-bar progress-bar-success1" role="progressbar" aria-valuenow="35"
                             aria-valuemin="0" aria-valuemax="100" style="width:35%">
                            Low Risk
                        </div>
                    </div>
                </div>
            </div>
        </div>









        <div class="panel panel-info img-rounded col-sm-6">
            <div class="panel-heading"><img src="cpl.png" height="25" width="25"> CPL Ahmad</div>
            <div class="panel-body">
                <div class="col-sm-3">

                    <div><img class="bordered-thick" src="coverflow.jpg" height="100" width="80"></div>

                </div>

                <div class="col-sm-9">

                    <img class="img-icons"  src="Icons/Temperature/red_temperature.png" height="50" width="30">

                    <img class="img-icons" src="Icons/Stress/white_stress.png" height="50" width="50">

                    <img  src="Icons/Heart/green_heart.png" height="50" width="50">

                    <img     src="Icons/Water/green_water.png" height="50" width="50">

                    <%--<img src="Icons/Temperature/white_temperature.png" height="50" width="30">

                <img src="Icons/Temperature/green_temperature.png" height="50" width="30">

                <img src="Icons/Temperature/yellow_temperature.png" height="50" width="30">

                <img src="Icons/Temperature/red_temperature.png" height="50" width="30">

                <img src="Icons/Stress/white_stress.png" height="50" width="50">

                <img src="Icons/Stress/green_stress.png" height="50" width="50">

                <img src="Icons/Stress/yellow_stress.png" height="50" width="50">

                <img src="Icons/Stress/red_stress.png" height="50" width="50">

                <img src="Icons/Heart/white_heart.png" height="50" width="50">

                <img src="Icons/Heart/green_heart.png" height="50" width="50">

                <img src="Icons/Heart/yellow_heart.png" height="50" width="50">

                <img src="Icons/Heart/red_heart.png" height="50" width="50">

                <img src="Icons/Water/white_water.png" height="50" width="50">--%>
                    <br>
                    <br>
                    <div class="progress">
                        <div class="progress-bar progress-bar-danger1" role="progressbar" aria-valuenow="100"
                             aria-valuemin="0" aria-valuemax="100" style="width:100%">
                            High Risk! Contact medics immediately!
                        </div>
                    </div>
                </div>
            </div>



        </div>

        <!-- Modal -->
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"> LCP Beng</h4>
                    </div>
                    <div class="modal-body">
                        <p>Temperature : <%=tempe%><br>
                            Stress Value : <%=gsr%><br>
                            Heart Rate : <%=hrate%><br>
                            Wate intake: <%=flow%></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>

            </div>
        </div>
        <script>
            $('#myPanel').click(function (e) {
                e.preventDefault();
                $("#myModal").modal();
            });
        </script>

    </body>
</html>
