package com.asiainfo.csc.common.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBODistrictInfoValue extends DataStructInterface{

  public final static  String S_ParentDistrictId = "PARENT_DISTRICT_ID";
  public final static  String S_CourseFlag = "COURSE_FLAG";
  public final static  String S_SortId = "SORT_ID";
  public final static  String S_AreaCode = "AREA_CODE";
  public final static  String S_DistrictEnglishName = "DISTRICT_ENGLISH_NAME";
  public final static  String S_RegionId = "REGION_ID";
  public final static  String S_DistrictTypeId = "DISTRICT_TYPE_ID";
  public final static  String S_DistrictId = "DISTRICT_ID";
  public final static  String S_CenterInfoCode = "CENTER_INFO_CODE";
  public final static  String S_PostCode = "POST_CODE";
  public final static  String S_DistrictName = "DISTRICT_NAME";
  public final static  String S_DistrictTwoNumber = "DISTRICT_TWO_NUMBER";
  public final static  String S_Notes = "NOTES";


public long getParentDistrictId();

public long getCourseFlag();

public long getSortId();

public String getAreaCode();

public String getDistrictEnglishName();

public String getRegionId();

public long getDistrictTypeId();

public long getDistrictId();

public String getCenterInfoCode();

public long getPostCode();

public String getDistrictName();

public long getDistrictTwoNumber();

public String getNotes();


public  void setParentDistrictId(long value);

public  void setCourseFlag(long value);

public  void setSortId(long value);

public  void setAreaCode(String value);

public  void setDistrictEnglishName(String value);

public  void setRegionId(String value);

public  void setDistrictTypeId(long value);

public  void setDistrictId(long value);

public  void setCenterInfoCode(String value);

public  void setPostCode(long value);

public  void setDistrictName(String value);

public  void setDistrictTwoNumber(long value);

public  void setNotes(String value);
}
