package com.asiainfo.aiga.node_view.bo;

/**
 * NodeViewId entity. @author MyEclipse Persistence Tools
 */

public class NodeViewId implements java.io.Serializable
{

	// Fields    

	private Integer nodeId;

	private Integer parentId;

	private String nodeName;

	private String nodeTable;

	// Constructors

	/** default constructor */
	public NodeViewId()
	{
	}

	/** minimal constructor */
	public NodeViewId(Integer nodeId, String nodeTable)
	{
		this.nodeId = nodeId;
		this.nodeTable = nodeTable;
	}

	/** full constructor */
	public NodeViewId(Integer nodeId, Integer parentId, String nodeName, String nodeTable)
	{
		this.nodeId = nodeId;
		this.parentId = parentId;
		this.nodeName = nodeName;
		this.nodeTable = nodeTable;
	}

	// Property accessors

	public Integer getNodeId()
	{
		return this.nodeId;
	}

	public void setNodeId(Integer nodeId)
	{
		this.nodeId = nodeId;
	}

	public Integer getParentId()
	{
		return this.parentId;
	}

	public void setParentId(Integer parentId)
	{
		this.parentId = parentId;
	}

	public String getNodeName()
	{
		return this.nodeName;
	}

	public void setNodeName(String nodeName)
	{
		this.nodeName = nodeName;
	}

	public String getNodeTable()
	{
		return this.nodeTable;
	}

	public void setNodeTable(String nodeTable)
	{
		this.nodeTable = nodeTable;
	}

	public boolean equals(Object other)
	{
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof NodeViewId))
			return false;
		NodeViewId castOther = (NodeViewId) other;

		return ((this.getNodeId() == castOther.getNodeId()) || (this.getNodeId() != null && castOther.getNodeId() != null && this.getNodeId().equals(castOther.getNodeId()))) && ((this.getParentId() == castOther.getParentId()) || (this.getParentId() != null && castOther.getParentId() != null && this.getParentId().equals(castOther.getParentId())))
				&& ((this.getNodeName() == castOther.getNodeName()) || (this.getNodeName() != null && castOther.getNodeName() != null && this.getNodeName().equals(castOther.getNodeName()))) && ((this.getNodeTable() == castOther.getNodeTable()) || (this.getNodeTable() != null && castOther.getNodeTable() != null && this.getNodeTable().equals(castOther.getNodeTable())));
	}

	public int hashCode()
	{
		int result = 17;

		result = 37 * result + (getNodeId() == null ? 0 : this.getNodeId().hashCode());
		result = 37 * result + (getParentId() == null ? 0 : this.getParentId().hashCode());
		result = 37 * result + (getNodeName() == null ? 0 : this.getNodeName().hashCode());
		result = 37 * result + (getNodeTable() == null ? 0 : this.getNodeTable().hashCode());
		return result;
	}

}