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
            <input type="number" id="guess">
            <button id="submitGuess">Klik her for at commite dit gæt</button>
            <div id="response" style="background-color: red; float: right"></div>
        </div>

        <script>
            $(document).ready(function () {

                var urlAll = "http://knowyourclass-plaul.rhcloud.com/api/all";
                var urlRand = "http://knowyourclass-plaul.rhcloud.com/api/random";
                var urlGame = "http://knowyourclass-plaul.rhcloud.com/api/guess/";
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
                            UfID = randomGuy._id;

                        }
                    };
                    ajaxRequest.open("GET", urlRand, true);
                    ajaxRequest.send();
                };
                $("#getGame").click(function ()
                {
                    $("#response").html("");
                    getRandom();
                    urlGame = "http://knowyourclass-plaul.rhcloud.com/api/guess/";
                });

                var guessing = function ()
                {
                    var ajaxRequest = new XMLHttpRequest();
                    fID = $("#guess").val();
                    urlGame = urlGame.concat(fID + "/" + UfID);
                    ajaxRequest.onreadystatechange = function ()
                    {
                        if (ajaxRequest.readyState == 4 && ajaxRequest.status == 200)
                        {
                            var john = JSON.parse(ajaxRequest.responseText);
                            console.log(john);
                            if(john.status === "true")
                            {
                                $("#response").css("background-color", "green");
                            }
                            $("#response").text(john.status);
                        }
                    };
                    console.log(urlGame);
                    ajaxRequest.open("GET", urlGame, true);
                    ajaxRequest.send();
                };

                $("#submitGuess").click(function ()
                {
                    guessing();
                });

            });


        </script>
    </body>
</html>
