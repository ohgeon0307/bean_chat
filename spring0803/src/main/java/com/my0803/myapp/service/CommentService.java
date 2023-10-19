package com.my0803.myapp.service;

import java.util.ArrayList;

import com.my0803.myapp.domain.CommentVo;

public interface CommentService {

	public int commentInsert(CommentVo cv);

	public ArrayList<CommentVo> commentSelectAll(int bidx);
	
	public int commentDelete (int cidx);
	

	
}
