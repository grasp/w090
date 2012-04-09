# To change this template, choose Tools | Templates
# and open the template in the editor.
out = File.new("routenave.html","w")
out<<"<table class='table'>"
open("routes.txt").each do |line|
  # seperated_line=line.split(/\s+/)
  # puts seperated_line[0]||""+"-"+seperated_line[1]||""

  seperated_line= line.split()
  new_line=String.new

  #resource=(seperated_line[2]||"").match(/\/w+\W/)
  
#  new_line<<"<td>#{resource}</td>"

  if (seperated_line[2]||"").match("rforum")
      new_line="<tr><td><a href='#{(seperated_line[2]||"").gsub("(.:format)","")}'>"+(seperated_line[0]||" ")+"</a>"
  else
      new_line="<tr><td><a href='/rforum#{(seperated_line[2]||"").gsub("(.:format)","")}'>"+(seperated_line[0]||" ")+"</a>"
  end

  new_line<<"</td>"
    new_line<<"<td>"
  new_line<<"#{seperated_line[0]}"
  new_line<<"</td>"
  new_line<<"<td>"
  new_line<<"#{seperated_line[1]}"
  new_line<<"</td>"
  new_line <<"<td>"
  new_line <<"#{seperated_line[2]}"
  new_line <<"</td>"
  new_line <<"<td>"
 new_line <<"#{seperated_line[3]}"
  new_line<<"</td>"
  new_line<<"</tr>"
  new_line<<"\n"
  puts new_line
  out << new_line
  end
  out<<"</table>"
  
  out.close