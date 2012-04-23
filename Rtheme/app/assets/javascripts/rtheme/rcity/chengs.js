// All this logic will automatically be available in application.js.


function ajax_load_link_to_modal(){
	$("#fcheng .lineselect").live("click",function(){
		$("#fcheng .fcheng").load(this.href);
		$(".fname").text(this.text);
		$(".fcityname").val(this.text);
		$(".fcitycode").val($(this).attr("href").match(/\d+/));
		return false;
	});

		$("#tcheng .lineselect").live("click",function(){
		$("#tcheng .tcheng").load(this.href);
		$(".tname").text(this.text);
		$(".tcityname").val(this.text);
		$(".tcitycode").val($(this).attr("href").match(/\d+/));
		return false;
	})
}


function rcity_chengs_load_modal_for_line_select(){
	//alert("cheng is loaded!");
   $('#myModal').modal({ keyboard: true, backdrop: true, show: false});
   $('#tab').tab('show')

   $('#myModal').on('show', function () {
   	ajax_load_link_to_modal();
    })
  return false;
}
