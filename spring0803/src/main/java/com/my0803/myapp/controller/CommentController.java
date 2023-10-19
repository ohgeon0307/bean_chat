package com.my0803.myapp.controller;

import java.util.ArrayList;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.my0803.myapp.domain.CommentVo;
import com.my0803.myapp.service.CommentService;

@RestController
@RequestMapping(value="/comment")
public class CommentController {

	@Autowired
	private CommentService cs;
	
	//@ResponseBody  //객체 리턴
	@RequestMapping(value="/commentWrite.do",method=RequestMethod.POST)
	public JSONObject commentWrite(CommentVo cv) {		
		
	//	String str = null;
		int value = 0;
		//str = "{\"value\" : \""+value+"\"}";
		value = cs.commentInsert(cv);
		
		JSONObject js = new JSONObject();
		js.put("value", value);	
		
		return js;
	}
	
	@RequestMapping(value="/{bidx}/commentList.do")
	public JSONObject commentList(
			@PathVariable("bidx") int bidx
			) {	
	
		ArrayList<CommentVo> alist  =  cs.commentSelectAll(bidx);
		
		JSONObject js = new JSONObject();
		js.put("alist", alist);
	
		return js;
	}
		
	@RequestMapping(value="/{cidx}/commentDelete.do")
	public JSONObject commentDelete(
			@PathVariable("cidx") int cidx
			) {	
	
		int value  =  cs.commentDelete(cidx);
		
		JSONObject js = new JSONObject();
		
		js.put("value", value);
	
		return js;
	}
	
	
}
