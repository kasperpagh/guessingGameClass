<%-- 
    Document   : index
    Created on : Mar 11, 2016, 12:06:21 PM
    Author     : pagh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>

        <div>
            <div id="classMates" style="float: left">

            </div>

            <button id="getGame">Klik her for at spille</button>
            <div id="randomGuy" style="float: left">

            </div>
        </div>

        <script>
            $(document).ready(function () {

                var urlAll = "http://knowyourclass-plaul.rhcloud.com/api/all";
                var urlRand = "http://knowyourclass-plaul.rhcloud.com/api/random";
                var fID;
                var UfID;
                var randomGuy;

                var popList = function ()
                {
                    var ajaxRequest = new XMLHttpRequest();
                    var myClassMates = [];
                    ajaxRequest.onreadystatechange = function ()
                    {

                        if (ajaxRequest.readyState == 4 && ajaxRequest.status == 200)
                        {
                            var htmlString = "<table>";
                            myClassMates = JSON.parse(ajaxRequest.responseText);
                            for (i = 0; i < myClassMates.length; i++)
                            {
                                htmlString = htmlString.concat("<tr>");
                                htmlString = htmlString.concat("<td>" + myClassMates[i].name + "</td>");
                                htmlString = htmlString.concat("<td>" + myClassMates[i].friendlyID + "</td>");
                                htmlString = htmlString.concat("</tr>");
                            }
                            htmlString = htmlString.concat("</table>");
                            console.log("her er html string: " + htmlString.toString());
                            $("#classMates").html(htmlString);
                        }
                    }
                    ;
                    ajaxRequest.open("GET", urlAll, true);
                    ajaxRequest.send();
                };
                popList();


                var getRandom = function ()
                {
                    var ajaxRequest = new XMLHttpRequest();
                    
                    ajaxRequest.onreadystatechange = function ()
                    {
                        if (ajaxRequest.readyState == 4 && ajaxRequest.status == 200)
                        {
                            randomGuy = JSON.parse(ajaxRequest.responseText);

                            $("#randomGuy").text(randomGuy.description);

                        }
                    };
                    ajaxRequest.open("GET", urlRand, true);
                    ajaxRequest.send();
                };
                $("#getGame").click(function ()
                {
                    getRandom();
                });
            });


        </script>
    </body>
</html>
