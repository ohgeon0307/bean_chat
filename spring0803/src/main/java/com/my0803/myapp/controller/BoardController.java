package com.my0803.myapp.controller;

import java.io.IOException;
import java.net.InetAddress;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.my0803.myapp.domain.BoardVo;
import com.my0803.myapp.domain.PageMaker;
import com.my0803.myapp.domain.SearchCriteria;
import com.my0803.myapp.service.BoardService;
import com.my0803.myapp.util.UploadFileUtiles;
import com.mysql.cj.Session;

@Controller 
@RequestMapping(value="/board")
public class BoardController {
	
	@Autowired
	private BoardService bs;	
	
	@Autowired(required=false)
	private PageMaker pm;
	
	@Resource(name="uploadPath")
	String uploadPath;
	
	@RequestMapping(value="/boardWrite.do")
	public String boardWrite() {		
		
		return "/board/boardWrite";
	}
	
	@RequestMapping(value="/boardWriteAction.do")
	public String boardWriteAction(BoardVo bv,	
			@RequestParam("filename") MultipartFile filename,	HttpSession session) throws  Exception {	
		
		MultipartFile file  = filename;
	//	System.out.println("file"+file);
		String uploadedFileName = "";
		if (!file.getOriginalFilename().equals("")) {
			//업로드 시작하겠다
		 uploadedFileName = 	UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
		}
		
	//	System.out.println("uploadedFileName:"+uploadedFileName);
		
		String ip = InetAddress.getLocalHost().getHostAddress();
		bv.setFilename2(uploadedFileName);		
		bv.setIp(ip);
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
	//	int midx = (int)session.getAttribute("midx");
		bv.setMidx(midx);    //�α��� ȸ���������� bv��ü�� �߰������� ��´�
		
		int value = bs.boardInsert(bv);// 이부분
		System.out.println("값"+value);
		
	
		return "redirect:/";
	}
	
	@RequestMapping(value="/boardList.do")
	public String boardList(SearchCriteria scri, Model model) {
		
		int totalCount = bs.boardTotalCount(scri);
		pm.setScri(scri);
		pm.setTotalCount(totalCount);
		
		ArrayList<BoardVo> alist =  bs.boardSelectAll(scri);
		model.addAttribute("alist", alist);
		model.addAttribute("pm", pm);
		
		return "/board/boardList";
	}
		
	@RequestMapping(value="/boardContents.do")
	public String boardContents(@RequestParam("bidx") int bidx,Model model) {	
		
		bs.boardCntUpdate(bidx);
		BoardVo bv = bs.boardSelectOne(bidx);		
		model.addAttribute("bv", bv);
		
		return "/board/boardContents";
	}
	
	@RequestMapping(value="/boardModify.do")
	public String boardModify(@RequestParam("bidx") int bidx,Model model) {		
		
		BoardVo bv = bs.boardSelectOne(bidx);		
		model.addAttribute("bv", bv);
		
		return "/board/boardModify";
	}

	



	   
	   @RequestMapping(value="/boardModifyAction.do")
	   public String boardModifyAction(BoardVo bv) {
	      
	      int value = bs.boardModify(bv);
	      System.out.println("입력값은? : "+value);
	      
	      if(value > 0) {
	         return "redirect:/board/boardContents.do?bidx="+bv.getBidx();
	      } else {
	         return "redirect:/board/boardList.do";
	      }
	   }

	   
		@RequestMapping(value="/boardDelete.do")
		public String boardDelete(@RequestParam("bidx") int bidx,Model model) {		
		
			
			BoardVo bv = bs.boardSelectOne(bidx);		
			model.addAttribute("bv", bv);
			
			
			return "/board/boardDelete";
		}
	  
		@RequestMapping(value="/boardDeleteAction.do")
		public String boardDeleteAction(BoardVo bv) {		
		
			int bidx = bv.getBidx();
			String pwd = bv.getPwd();
			int value = bs.boardDelete(bidx,pwd);
			
			return "redirect:/board/boardList.do";
		}

		@RequestMapping(value="/boardReply.do")
		public String boardReply(BoardVo bv,Model model) {		
		
			model.addAttribute("bv",bv);
			
			return "/board/boardReply";
		}

		
		@RequestMapping(value="/boardReplyAction.do")
		public String boardReplyAction(BoardVo bv, HttpSession session,Model model) {		
					
			int midx = (int)session.getAttribute("midx");
			bv.setMidx(midx); 
			
			int value = bs.boardReply(bv);	
			
			 System.out.println("값:"+value);
			int bidx = bv.getBidx();
			
			return "redirect:/board/boardContents.do?bidx="+bidx;
		}
		
		
		

	}

