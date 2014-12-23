function openWorkfowHandle(workflow_id){
  window.showModalDialog('/workflow/workflow_handle.jsp?WORKFLOW_ID='+ workflow_id,null,'status:no;dialogWidth:700px;dialogHeight:600px');
}