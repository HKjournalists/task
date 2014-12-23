package com.asiainfo.aiga.node_view.bo;


/**
 * NodeView entity. @author MyEclipse Persistence Tools
 */

public class NodeView implements java.io.Serializable
{

	// Fields    

	private NodeViewId id;

	// Constructors

	/** default constructor */
	public NodeView()
	{
	}

	/** full constructor */
	public NodeView(NodeViewId id)
	{
		this.id = id;
	}

	// Property accessors

	public NodeViewId getId()
	{
		return this.id;
	}

	public void setId(NodeViewId id)
	{
		this.id = id;
	}

}