function ajax_load_href_rcompany(){

	$(".cargoshow").live("click",function(){
	  $('#CargoShowModal .modal-body').empty();
	  $('#CargoShowModal .modal-body').load($(this).attr("data-link"));	  
	}) 
}



function load_modal_for_rcompany_show(){
   $('#CargoShowModal').modal({ keyboard: true, backdrop: true, show: false});
   $('#CargoShowModal').on('show', function () {
     ajax_load_href_rcompany();
   })
  return false;
}
