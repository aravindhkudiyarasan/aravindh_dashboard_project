package com.learn.Aravindh.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.learn.Aravindh.dao.TableDAO;
import com.learn.Aravindh.entity.Systemreport;

@Service
public class TableServiceImpl implements TableService {

	@Autowired
	private TableDAO tableDAO;
	
	@Transactional
	public List<Systemreport> getTableData() {
		return tableDAO.getTableData();
	}

}
