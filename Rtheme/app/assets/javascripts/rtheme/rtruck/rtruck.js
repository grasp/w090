function ajax_load_href_truck(){

	$(".truckshow").live("click",function(){
	  $('#TruckShowModal .modal-body').empty();
	  $('#TruckShowModal .modal-body').load($(this).attr("data-link"));	  
	}) 
}



function load_modal_for_truck_show(){
   $('#TruckShowModal').modal({ keyboard: true, backdrop: true, show: false});
   $('#TruckShowModal').on('show', function () {
     ajax_load_href_truck();
   })
  return false;
}