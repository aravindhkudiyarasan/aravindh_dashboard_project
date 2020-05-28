package com.learn.Aravindh.dao;

import java.util.List;

import javax.persistence.EntityManagerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.learn.Aravindh.entity.Systemreport;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

@Repository
public class TableDAOImpl implements TableDAO {
	
	@Autowired
	private EntityManagerFactory entityManagerFactory;

	@Override
	public List<Systemreport> getTableData() {
		
		Session currentSession = entityManagerFactory.unwrap(SessionFactory.class).openSession();
		Query theQuery = currentSession.createQuery("from Systemreport order by id",Systemreport.class);
		List<Systemreport> result = theQuery.getResultList();
		
		currentSession.close();
		return result;
	}

}
