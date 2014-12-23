create index INX_rfe_ele_id on AIGA_R_FUN_ELEM (elem_id);
create index INX_rfe_fun_id on AIGA_R_FUN_ELEM (fun_id);

alter table ALM_WORKFLOW
  add constraint Pri_alm_workflow_wtfid primary key (WF_ITEM_ID);
create index INX_ALM_WF_LINK_ID on ALM_WORKFLOW (LINK_NO);

create index INX_ALM_WO_LINK_ID on ALM_WORKORDER (LINK_NO);
create index awo_order_type_id on ALM_WORKORDER (obj_type, obj_id, exec_staff_id);

create index INX_ALM_h_WO_LINK_ID on ALM_HIS_WORKORDER (LINK_NO);
create index awo_h_order_type_id on ALM_HIS_WORKORDER (obj_type, obj_id, exec_staff_id);