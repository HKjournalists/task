package com.lb.app.privilege.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.SequenceGenerator;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@JsonIgnoreProperties(value={"users"})
public class Sys_Role {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator="role$seq")
	@SequenceGenerator(name="role$seq",sequenceName="role$seq")
	private long roleid;
	
	
	private String name;
	private String memo;

	
	@ManyToMany(mappedBy="roles")
	private Set<Sys_User> users = new HashSet<Sys_User>();;
	
	
	public long getRoleid() {
		return roleid;
	}
	public void setRoleid(long id) {
		this.roleid = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public Set<Sys_User> getUsers() {
		return users;
	}
	public void setUsers(Set<Sys_User> users) {
		this.users = users;
	}
	
}
