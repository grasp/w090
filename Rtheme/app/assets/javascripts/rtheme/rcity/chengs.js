// All this logic will automatically be available in application.js.


function ajax_load_link_to_modal(){
	$("#fcheng .lineselect").live("click",function(){
		//alert("line slect clicked!")
		$("#fcheng .fcheng").load(this.href);
		$(".fname").text(this.text.replace(/->/,''));
		$(".fcityname").val(this.text.replace(/->/,''));
		$(".fcitycode").val($(this).attr("href").match(/\d+/));
		return false;
	});

		$("#tcheng .lineselect").live("click",function(){
		$("#tcheng .tcheng").load(this.href);
		$(".tname").text(this.text.replace(/->/,''));
		$(".tcityname").val(this.text.replace(/->/,''));
		$(".tcitycode").val($(this).attr("href").match(/\d+/));
		return false;
	})
}


function rcity_chengs_load_modal_for_line_select(){
	//alert("cheng is loaded!");
   $('#myModal').modal({ keyboard: true, backdrop: true, show: false});
   //$('#tab').tab('show')
   $('a[href=#fcheng]').tab('show');

   $('#myModal').on('show', function () {
   	ajax_load_link_to_modal();
    })
  return false;
}
