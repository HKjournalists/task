package com.lb.app.privilege.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Transient;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
public class Sys_User {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator="user$seq")
	@SequenceGenerator(name="user$seq",sequenceName="user$seq")
	private long userid;
	
	private String username;
	private String password;
	private String realname;
	private String email;
	private String mobile;
	private String department;
	private String manager;
	
	@Transient
	private String roleids;
	@Transient
	private String confirm;
	
	
    @ManyToMany(targetEntity=com.lb.app.privilege.model.Sys_Role.class,
    cascade = {javax.persistence.CascadeType.PERSIST, javax.persistence.CascadeType.MERGE},
    fetch = FetchType.EAGER
    )
    @Fetch(FetchMode.SUBSELECT)
	@JoinTable(name="sys_r_user_role", joinColumns={ @JoinColumn(name="userid")}, 
	    inverseJoinColumns={ @JoinColumn(name = "roleid") })
	private Set<Sys_Role> roles = new HashSet<Sys_Role>();
	
	
	public long getUserid() {
		return userid;
	}
	public void setUserid(long id) {
		this.userid = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public Set<Sys_Role> getRoles() {
		return roles;
	}
	public void setRoles(Set<Sys_Role> roles) {
		this.roles = roles;
	}
	
	public String getRoleids() {
		return roleids;
	}
	public void setRoleids(String roldids) {
		this.roleids = roldids;
	}
	public String getConfirm() {
		return confirm;
	}
	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}
}
