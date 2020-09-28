
function addText()
{
    var msg = document.getElementById('h').value;
    if(msg != ""){
    	document.getElementById("h").value = "";

	    /*olist.scrollTop = olist.scrollHeight; //Adjust Height*/
	    var xmlhttp;
	    if (window.XMLHttpRequest)
	    {// code for IE7+, Firefox, Chrome, Opera, Safari
	        xmlhttp = new XMLHttpRequest();
	    }
	    else
	    {// code for IE6, IE5
	        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	    }
	
	    xmlhttp.open("POST", "send_message_con.jsp?message=" + msg, true);
	    
	    xmlhttp.send(null);
    }
}

function reloaddata()
{
    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }


    xmlhttp.open("POST", "show_chat.jsp", true);

    xmlhttp.onreadystatechange = function()
    {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
        {

            document.getElementById("content").innerHTML = xmlhttp.responseText;           
            autoScroll()

        }
    }
    xmlhttp.send(null);
}

function autoScroll(){
	olist = document.getElementById("abcd"); //everything in id list
    olist.scrollTop = olist.scrollHeight;
}