-- Add/modify columns 
alter table AIGA_TEST_SUB_TASK modify possible_test default 1;
-- Add/modify columns 
alter table AIGA_TEST_SUB_TASK modify possible_product default 1;
alter table AIGA_TEST_SUB_TASK modify possible_back default 1;
-- Add comments to the columns 
comment on column AIGA_TEST_SUB_TASK.is_performance
  is '是否性能测试（1为可测，0为不可测，默认可测，三个可测性相同）';
comment on column AIGA_TEST_SUB_TASK.possible_test
  is '测试环境可测性（1为可测，0为不可测，默认可测，三个可测性相同）';
comment on column AIGA_TEST_SUB_TASK.is_performance
  is '是否性能测试';

---索引
create unique index index_busi_def_name on AIGA_BUSI (busi_name);
create unique index index_base_busi_name on AIGA_BASE_BUSI(busi_name);