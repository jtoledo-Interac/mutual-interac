var spreadsheet_link = "https://docs.google.com/spreadsheets/d/1bW0uk_JKvHCJt_4DHi_h1ufQepiakfDxUoZFBSK9HD4/edit?usp=sharing";
google.load("visualization", "1", {packages:["orgchart"]});
google.setOnLoadCallback(drawChart);

var employee;
var manager;
var employee_position;
var employee_img;

function imageExists(image_url){

    var http = new XMLHttpRequest();

    http.open('HEAD', image_url, false);
    http.send();

    return http.status != 404;

}

function drawChart() {
  
   var data = new google.visualization.DataTable();
        data.addColumn('string', 'Name');
        data.addColumn('string', 'Manager');
        data.addColumn('string', 'ToolTip');
  Papa.parse(spreadsheet_link, {
  download: true,
  complete: function(results) {
    iter = results.data;
    for(i= 0; i < iter.length; i++){
      values = iter[i];
      employee = toTitleCase(values[0]);
      manager  = toTitleCase(values[1]);
      employee_img = employee.split(" ").join("_") + ".jpg";
      employee_position = toTitleCase(values[2]);
      
      if(imageExists("./img/"+employee_img)){
        data.addRow([{v:employee, f: '<img  src = "./img/'+employee_img+'" class="img_thumbnail" onclick="showDialog(\''+employee_img+'\',\''+employee+'\',\''+employee_position+'\');" /><div class = "employee_text_thumbnail" style = "cursor: pointer;" onclick="showDialog(\''+employee_img+'\',\''+employee+'\',\''+employee_position+'\');"><b>'+employee+'</b></div>'+'<div style = "cursor: pointer;" onclick="showDialog(\''+employee_img+'\',\''+employee+'\',\''+employee_position+'\');" class = "employee_position_thumbnail">'+employee_position+'</div>'}, manager, employee_position]);
      }else{
        employee_img = "default_face.png";
        data.addRow([{v:employee, f: '<img  src = "./img/'+employee_img+'" class="img_thumbnail" onclick="showDialog(\''+employee_img+'\',\''+employee+'\',\''+employee_position+'\');" /><div class = "employee_text_thumbnail" style = "cursor: pointer;" onclick="showDialog(\''+employee_img+'\',\''+employee+'\',\''+employee_position+'\');"><b>'+employee+'</b></div>'+'<div style = "cursor: pointer;" onclick="showDialog(\''+employee_img+'\',\''+employee+'\',\''+employee_position+'\');" class = "employee_position_thumbnail">'+employee_position+'</div>'}, manager, employee_position]);
      }


      
    }
    var chart = new google.visualization.OrgChart(document.getElementById('columnchart'));
    
    chart.draw(data, {allowHtml:true});
  }
});
}



function toTitleCase(str)
{
    return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
}


function showDialog(employee_img, employee, employee_position)
{
    
    $("#dialog-modal").dialog(
    {
        width:  430,
        height: 480,
        modal:  true,
        resizable: false,

        open: function(event, ui)
        {
            
            console.log(event);
            $("#image_detail_info").attr("src", "./img/"+employee_img);
            $("#employee").html(employee);
            $("#employee_position").html(employee_position);
            
        }

     });


 
}
