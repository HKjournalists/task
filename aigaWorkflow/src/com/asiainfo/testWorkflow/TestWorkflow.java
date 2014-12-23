package com.asiainfo.testWorkflow;

import java.util.HashMap;
import java.util.Map;

import com.ai.comframe.client.ComframeClient;

public class TestWorkflow {

	public static void main(String[] args)throws Exception{
		Map var = new HashMap();
		//启动流程
		//ComframeClient.getDefaultComframeClient().createWorkflow("com.asiainfo.test.testWorkflow", "1", "100", "10000", var, null, "");
		//回单
		//ComframeClient.getDefaultComframeClient().finishUserTask(0, "1", "Y", "Y", var);
	}
}
