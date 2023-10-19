package com.my0803.myapp.service;

import java.util.ArrayList;



import com.my0803.myapp.domain.BoardVo;
import com.my0803.myapp.domain.SearchCriteria;


//게시판 메소드를 정의해놓은 인터페이스
public interface BoardService {
	

	public int boardInsert(BoardVo bv); //boardInsert객체값을 받아옴
		
		
	public ArrayList<BoardVo> boardSelectAll(SearchCriteria scri);
	
	
	public int boardTotalCount(SearchCriteria scri);
	
	
	public BoardVo boardSelectOne(int bidx);

	
	public int boardCntUpdate(int bidx);


	public int boardModify(BoardVo bv);
	

	public int boardDelete(int bidx, String pwd);
	
	public int boardReply(BoardVo bv);
}
