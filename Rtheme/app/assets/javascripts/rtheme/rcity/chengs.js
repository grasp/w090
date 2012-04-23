// All this logic will automatically be available in application.js.


function ajax_load_link_to_modal(){
	$(".lineselect").live("click",function(){
		$(".modal-body").load(this.href);
		//2alert("you click the city link!")
		return false;
	})
}


function load_modal_for_line_select(){
	//alert("cheng is loaded!");
   $('#myModal').modal({ keyboard: true, backdrop: true, show: false});
   $('#mytab').tab('show')

   $('#myModal').on('show', function () {
   	ajax_load_link_to_modal();

    })

}
